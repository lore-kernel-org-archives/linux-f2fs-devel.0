From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 11/12] f2fs: add noextent_cache mount option
Date: Fri, 3 Jul 2015 21:57:35 -0700
Message-ID: <20150704045735.GB15817@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-11-git-send-email-jaegeuk@kernel.org>
	<COL402-EAS3119D4AFA99D9454639B68CAB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZBFWG-0001Tl-V7
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 04:57:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZBFWF-0007JT-KB for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 04:57:40 +0000
Content-Disposition: inline
In-Reply-To: <COL402-EAS3119D4AFA99D9454639B68CAB970@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Jul 02, 2015 at 08:35:34PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, June 30, 2015 2:40 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 11/12] f2fs: add noextent_cache mount option
> > 
> > This patch adds noextent_cache mount option.
> 
> How about adding some descriptions in Documentation to help our user?
> 
> The other thing is we'd better to show 'noextent_cache' option when user
> lookups the mount options.
> 
> How about adding codes as below?
> if (test_opt(sbi, EXTENT_CACHE))
> 	seq_puts(seq, ",extent_cache");
> +else
> +	seq_puts(seq, ",noextent_cache");
> 

Agreed.

Thanks,

> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> The other looks good to me, so please add:
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
