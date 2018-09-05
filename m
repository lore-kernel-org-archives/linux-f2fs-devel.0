From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Tue, 4 Sep 2018 21:12:10 -0700
Message-ID: <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fxPAz-0002MO-Ow
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 04:12:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxPAv-008hvb-Kj
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 04:12:21 +0000
Content-Disposition: inline
In-Reply-To: <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Patrick Doyle <wpdster@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

On 09/05, Chao Yu wrote:
> On 2018/9/5 0:28, Patrick Doyle wrote:
> > I have created an f2fs partition on which to build embedded Linux
> > images (using Yocto/OpenEmbedded/Bitbake).
> > 
> > I just had a build fail where all 20 parallel makes failed with errors
> > of the form:
> > 
> > OSError: [Errno 5] Input/output error:
> > '/home/wpd/src/20180904-test/apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/libxml2/2.9.2-r0/temp/fifo.32426'
> 
> I don't remember there is any restriction to create named pipes/FIFO. If you can
> provider more info about the building failure, maybe I can help to trouble shoot
> the issue.
> 
> Is there no more free inode space? can you show me filesystem usage by 'stat -f'?

Me too. I don't think F2FS does something on pipes. :P

> 
> > 
> > This build completed successfully in the past, including just this
> > morning (on this filesystem).
> > 
> > I believe by design (and benchmarks I have researched) that F2FS is
> > the best approach for SSD based file systems, but this will mark the
> > second time in less than a week of having put F2FS in operation that I
> > will have to back up my partition, reformat it with different flags,
> > and restore it from my backup.   I am now frustrated.
> > 
> > What options would you recommend for a 1TB SSD formatted with F2FS to
> > be used in an environment that generates Linux system images?  This
> > environment creates many object files, named pipes, logfiles, etc...
> > 
> > I will start my new backup now, and hope to learn your recommendation
> > before I am ready to issue my next mkfs command.
> 
> Do you upgrade both mkfs and kernel? and use mkfs -i to format your ssd device?
> 
> Thanks,
> 
> > 
> > --wpd
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > 
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
