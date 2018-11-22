From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: release 1.12.0
Date: Thu, 22 Nov 2018 01:51:38 -0800
Message-ID: <20181122095138.GA42184@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181121193644.8360-1-jaegeuk@kernel.org>
 <20181122095559.6542464a@leda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gPleS-0003py-FG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 09:52:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gPleD-00CYwe-6X
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Nov 2018 09:52:00 +0000
Content-Disposition: inline
In-Reply-To: <20181122095559.6542464a@leda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christian Hesse <list@eworm.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 11/22, Christian Hesse wrote:
> Jaegeuk Kim <jaegeuk@kernel.org> on Wed, 2018/11/21 11:36:
> > This release includes:
> >  - add android default configuration
> >  - fix resgid/resuid
> >  - add more sanity checks
> >  - fix corrupted quota in clean umount
> >  - add superblock checksum
> > 
> > And, there are several bug fixes in fsck.f2fs/sload.f2fs/mkfs.f2fs.
> 
> Can you push a tag to git, please? A signed one is preferred.
> Same goes for release 1.11.1, still missing a tag there.

My bad. I just pushed a signed v1.12.0.

Thanks,

> 
> Thanks a lot!
> -- 
> main(a){char*c=/*    Schoene Gruesse                         */"B?IJj;MEH"
> "CX:;",b;for(a/*    Best regards             my address:    */=0;b=c[a++];)
> putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}
