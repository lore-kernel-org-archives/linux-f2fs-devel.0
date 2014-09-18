From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: systemd-fsck and f2fs
Date: Wed, 17 Sep 2014 23:09:42 -0700
Message-ID: <20140918060942.GA2501@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <2173116.zc0VPd5yib@pats-main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XUUud-0003mu-OF
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 06:09:51 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XUUuc-0004ww-Hq for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Sep 2014 06:09:51 +0000
Content-Disposition: inline
In-Reply-To: <2173116.zc0VPd5yib@pats-main>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Patrick Houle <buddlespit@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On Wed, Sep 17, 2014 at 07:17:11PM -0400, Patrick Houle wrote:
> I know that your master branch has fixed the systemd-fsck and f2fs 
> problem with the "fsck.f2fs: invalid option -- 'a'". But your latest tag is 
> 1.3.0 from 2/2014 which doesn't contain the fix in your master branch. 
> Any idea when this will be added or updated? I know I could just 
> download the git and compile it myself, but that will still leave a 
> buggy package in the archlinux repo.

Do you mean it needs a tag for new version on HEAD?
Anyway, as a matter of fact, I'm thinking to do that.

Thanks,

> 
> Patrick Houle
> buddlespit@gmail.com
> 
> ------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
