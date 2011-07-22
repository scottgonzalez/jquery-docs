<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:template match="/">

<html>
<link href="http://static.jquery.com/api/style.css" rel="stylesheet" />
<link href="http://static.jquery.com/api/prettify.css" rel="stylesheet" />
<div id="jq-siteContain" class="api-jquery-com"><div id="jq-primaryContent">
<fieldset class="toc">
	<legend>Contents</legend>
	<ul class="toc-list">
		<xsl:for-each select="//entry">
			<xsl:variable name="entry-name" select="@name" />
			<li>
				<a href="#{concat(@name,position())}">
				<xsl:value-of select="@name" /><xsl:if test="@type='method'">(<xsl:if test="signature/argument"><xsl:text> </xsl:text>
					<xsl:for-each select="signature[1]/argument">
						<xsl:if test="position() &gt; 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:if test="@optional">[ </xsl:if>
						<!-- TODO add @type?! -->
						<xsl:value-of select="@name" />
						<xsl:if test="@optional"> ]</xsl:if>
						</xsl:for-each>
				<xsl:text> </xsl:text></xsl:if>)</xsl:if>
					<xsl:text> </xsl:text>
					<!-- TODO why put the desc in the title?? -->
					<span class="desc">
						<xsl:value-of select="desc" />
					</span>
				</a>
			<!-- Outdated? There's no type=method on entry elements anymore? -->
			<xsl:if test="@type='method'">
				<ul>
					<xsl:for-each select="signature">
						<li>
							<a>
								<xsl:attribute name="href">
								#<xsl:value-of select="$entry-name" />
									<xsl:for-each select="argument">
										<xsl:variable name="argument-name" select="@name" />
										<xsl:text>-</xsl:text><xsl:value-of select="translate($argument-name, ')(', '')"/>
									</xsl:for-each>
								</xsl:attribute>
								<xsl:if test="not(contains($entry-name, '.'))">.</xsl:if><xsl:value-of select="$entry-name" />(<xsl:if test="argument"><xsl:text> </xsl:text>
									<xsl:for-each select="argument">
										<xsl:if test="position() &gt; 1">
											<xsl:text>, </xsl:text>
										</xsl:if>
									<xsl:if test="@optional">[ </xsl:if>
										<xsl:value-of select="@name" />
									<xsl:if test="@optional"> ]</xsl:if>
									</xsl:for-each><xsl:text> </xsl:text></xsl:if>)
							</a>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:if>
			</li>
		</xsl:for-each>
	</ul>
</fieldset>

<xsl:for-each select="//entry">
<xsl:variable name="entry-name" select="@name" />
<xsl:variable name="entry-type" select="@type" />
<xsl:variable name="entry-index" select="position()" />
<xsl:variable name="number-examples" select="count(example)" />
<div class="entry {@type} jq-box" id="{concat(@name,position())}">
	<h2>
		<span class="name"><xsl:value-of select="@name" /><xsl:if test="@type='method'">(<xsl:if test="signature/argument"><xsl:text> </xsl:text>
			<xsl:for-each select="signature[1]/argument">
				<xsl:if test="position() &gt; 1">
					<xsl:text>, </xsl:text>
				</xsl:if>
				<xsl:if test="@optional">[ </xsl:if>
						<xsl:value-of select="@name" />
				<xsl:if test="@optional"> ]</xsl:if>
				</xsl:for-each>
			<xsl:text> </xsl:text></xsl:if>)</xsl:if></span>
		<xsl:text> </xsl:text>
		<span class="desc"><xsl:value-of select="desc" /></span>
	</h2>
	<div class="entry-details">
		<xsl:if test="@return">
			<p class="returns">
				Returns: <a class="return" href="/Types#{@return}"><xsl:value-of select="@return" /></a>
			</p>
		</xsl:if>
		<xsl:if test="options">
			<h3>Options</h3>
			<dl>
				<xsl:for-each select="options[1]/option">
					<xsl:variable name="option-name" select="@name" />
					<xsl:variable name="option-type" select="@type" />
					<dt>
						<xsl:attribute name="id">option-<xsl:value-of select="$option-name" /></xsl:attribute>
						<xsl:if test="added">
							<span class="versionAdded">version added: <xsl:value-of select="added" /></span>
						</xsl:if>
						<h4 class="name">
							<xsl:value-of select="$option-name" />
						</h4>
						<span class="type"><xsl:value-of select="$option-type" /></span>
						<xsl:if test="@default">
							<span class="default">default: <xsl:value-of select="@default" /></span>
						</xsl:if>
					</dt>
					<dd><xsl:copy-of select="desc/node()" /></dd>
				</xsl:for-each>
			</dl>
		</xsl:if>
		<xsl:if test="methods">
			<h3>Methods</h3>
			<dl>
				<xsl:for-each select="methods[1]/method">
					<xsl:variable name="method-name" select="@name" />
					<xsl:variable name="method-type" select="@type" />
					<dt>
						<xsl:attribute name="id">method-<xsl:value-of select="$method-name" /></xsl:attribute>
						<xsl:if test="added">
							<span class="versionAdded">version added: <xsl:value-of select="added" /></span>
						</xsl:if>
						<h4 class="name">
							<xsl:value-of select="$method-name" />
						</h4>
						<span class="type"><xsl:value-of select="$method-type" /></span>
					</dt>
					<dd><xsl:copy-of select="desc/node()" /></dd>
					<!-- TODO add arguments -->
				</xsl:for-each>
			</dl>
		</xsl:if>
		<xsl:if test="events">
			<h3>Events</h3>
			<dl>
				<xsl:for-each select="events[1]/event">
					<xsl:variable name="event-name" select="@name" />
					<xsl:variable name="event-type" select="@type" />
					<dt>
						<xsl:attribute name="id">event-<xsl:value-of select="$event-name" /></xsl:attribute>
						<xsl:if test="added">
							<span class="versionAdded">version added: <xsl:value-of select="added" /></span>
						</xsl:if>
						<h4 class="name">
							<xsl:value-of select="$event-name" />
						</h4>
						<span class="type"><xsl:value-of select="$event-type" /></span>
					</dt>
					<dd><xsl:copy-of select="desc/node()" /></dd>
					<!-- TODO refactor to reuse elsewhere -->
					<xsl:if test="argument">
						<xsl:text> </xsl:text>
						<ul>
							<xsl:for-each select="argument">
								<li>
									<!-- TODO take null=true into account -->
									<xsl:value-of select="@name" />
									<xsl:text>: </xsl:text>
									<xsl:value-of select="@type" />
									<xsl:text>, </xsl:text>
									<xsl:value-of select="desc" />
									<ul>
										<xsl:for-each select="property">
											<li>
												<xsl:value-of select="@name" />
												<xsl:text>: </xsl:text>
												<xsl:value-of select="@type" />
												<xsl:if test="desc">
													<xsl:text>, </xsl:text>
													<xsl:value-of select="desc" />
												</xsl:if>
											</li>
										</xsl:for-each>
									</ul>
								</li>
							</xsl:for-each>
						</ul>
					</xsl:if>
				</xsl:for-each>
			</dl>
		</xsl:if>
		<xsl:if test="signature">
			<h3>Signatures:</h3>
			<ul class="signatures">
				<xsl:for-each select="signature">
					<xsl:variable name="argument-name" select="@name" />
					<li class="signature">
						<xsl:attribute name="id">
							<xsl:value-of select="$entry-name" />
							<xsl:for-each select="argument">
								<xsl:text>-</xsl:text><xsl:value-of select="translate($argument-name, ')(', '')"/>
							</xsl:for-each>
						</xsl:attribute>
						<h4 class="name">
							<span class="versionAdded">version added: <xsl:value-of select="added" /></span>
							<xsl:if test="$entry-type='method'"><xsl:if test="not(contains($entry-name, '.'))">.</xsl:if></xsl:if><xsl:value-of select="$entry-name" /><xsl:if test="$entry-type='method'">(<xsl:if test="argument"><xsl:text> </xsl:text>
								<xsl:for-each select="argument">
									<xsl:if test="position() &gt; 1">
										<xsl:text>, </xsl:text>
									</xsl:if>
									<xsl:if test="@optional">[ </xsl:if>
											<xsl:value-of select="@name" />
									<xsl:if test="@optional"> ]</xsl:if>
								</xsl:for-each>
							<xsl:text> </xsl:text></xsl:if>)</xsl:if>
						</h4>
					<xsl:if test="argument">
							<dl class="arguments">
								<xsl:for-each select="argument">
								<dt><xsl:value-of select="@name" /></dt>
									<dd><xsl:copy-of select="desc/text()" /></dd>
								</xsl:for-each>
							</dl>
					</xsl:if>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>
		<xsl:if test="longdesc/node()">
			<h3>Description:</h3>
			<div class="longdesc">
				<xsl:copy-of select="longdesc/node()" />
			</div>
		</xsl:if>
		<xsl:if test="$number-examples &gt; 0">
			<h3>Example<xsl:if test="$number-examples &gt; 1">s</xsl:if>:</h3>
			<div class="entry-examples">
			<xsl:for-each select="example">
				<h4><xsl:if test="$number-examples &gt; 1">Example: </xsl:if><span class="desc"><xsl:value-of select="desc" /></span></h4>
<pre><code>
		<xsl:choose>
			<xsl:when test="html">
				<xsl:attribute name="class">example demo-code</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">example</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
	&lt;style type="text/css"&gt;<xsl:copy-of select="css/text()" />&lt;/style&gt;
	&lt;script type="text/javascript" src="/scripts/jquery-1.4.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
	<xsl:copy-of select="html/text()" />
&lt;script&gt;<xsl:copy-of select="code/text()" />&lt;/script&gt;

&lt;/body&gt;
&lt;/html&gt;
</code></pre>
	<xsl:if test="html">
				<h4>Demo:</h4>
				<div><xsl:choose>
					<xsl:when test="html">
						<xsl:attribute name="class">demo code-demo</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">demo</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
				</div>
	</xsl:if>
			</xsl:for-each>
			</div>
		</xsl:if>
	</div>
</div>

</xsl:for-each>
</div></div>
</html>

</xsl:template>

</xsl:stylesheet>
