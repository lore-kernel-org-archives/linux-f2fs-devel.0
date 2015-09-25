From: Chao Yu <yuchaochina@hotmail.com>
Subject: Re: [PATCH] f2fs: fix to correct freed section number
	during gc
Date: Fri, 25 Sep 2015 20:43:57 +0800
Message-ID: <BLU436-SMTP146E56621F24747C61FF419AB420@phx.gbl>
References: <00d601d0f539$3d893e90$b89bbbb0$@samsung.com>
	<20150922225352.GA31427@jaegeuk-mac02.mot.com>
	<012601d0f5e8$5315a690$f940f3b0$@samsung.com>
	<20150923210851.GB36564@jaegeuk-mac02.mot.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchaochina@hotmail.com>) id 1ZfSMm-0000et-SA
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 12:44:44 +0000
Received: from blu004-omc1s11.hotmail.com ([65.55.116.22])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZfSMm-0006Z8-20
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 12:44:44 +0000
In-Reply-To: <20150923210851.GB36564@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> On Sep 24, 2015, at 5:08 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> 
> Hi Chao,
> 
> On Wed, Sep 23, 2015 at 06:11:36PM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>> 
>>> -----Original Message-----
>>> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
>>> Sent: Wednesday, September 23, 2015 6:54 AM
>>> To: Chao Yu
>>> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH] f2fs: fix to correct freed section number during gc
>>> 
>>> Hi Chao,
>>> 
>>> On Tue, Sep 22, 2015 at 09:18:18PM +0800, Chao Yu wrote:
>>>> We pass 'nfree' to has_not_enough_free_secs to check whether there is
>>>> enough free section, but 'nfree' indicates the number of segment gced,
>>>> should alter the value to section number.
>>> 
>>> Yeah, but I think we need to increase nfree only when an entire section is gced
>>> completely, since sometimes nfree can be increased across sections.
>> 
>> Agree, I will fix that.
>> 
>> Still have one question, for foreground gc, why would we give up retry writing
>> out pages of last victim, but trying to select another victim for cleanup?
>> Will new introduced method cause long latency for caller than before?
> 
> Hmm. Very occasionally, I've seen that gc goes into an infinite loop to clean up
> one victim. In order to avoid that, I added giving up and then doing gc again.
> I think there is no problem in normal cases. Even in an abnormal case, I expect
> that next victim would be selected again because that should have lowest moving
> cost.

Got it, thanks for your explanation! :)

I have sent the v2 patch, please help to review.

Thanks,

> 
>> 
>> Thanks,
> 
> ------------------------------------------------------------------------------
> Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
> Get real-time metrics from all of your servers, apps and tools
> in one place.
> SourceForge users - Click here to start your Free Trial of Datadog now!
> http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
