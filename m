From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH RESEND] f2fs: maintain extent cache in	separated
	file
Date: Tue, 14 Jul 2015 18:10:50 +0800
Message-ID: <00f201d0be1d$78aa7370$69ff5a50$@samsung.com>
References: <00b001d0b964$e403d930$ac0b8b90$@samsung.com>
 <COL402-EAS121FDA80172BA8D25144E0CAB910@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <COL402-EAS121FDA80172BA8D25144E0CAB910@phx.gbl>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Fan Li <fanofcode.li@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Chao Yu [mailto:yuchaochina@hotmail.com]
> Sent: Thursday, July 09, 2015 12:16 AM
> To: 'Jaegeuk Kim'
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: maintain extent cache in separated file
> 
> >From 8956df8fa1a669e8e476456e4afe0eccd8174684 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Wed, 8 Jul 2015 20:49:05 +0800
> Subject: [PATCH] f2fs: maintain extent cache in separated file
> 
> This patch moves extent cache related code from data.c into extent_cache.c
> since extent cache is independent feature, and its codes are not relate to
> others in data.c, it's better for us to maintain them in separated place.
> 
> There is no functionality change, but several small coding style fixes
> including:
> * rename __drop_largest_extent to f2fs_drop_largest_extent for exporting;
> * rename misspelled word 'untill' to 'until';
> * remove unneeded 'return' in the end of f2fs_destroy_extent_tree().
> 

I think commit 0b84ceec9891 ("f2fs: don't try to split extents shorter than
F2FS_MIN_EXTENT_LEN") is conflict with commit 392a1c419916 ("f2fs: maintain
extent cache in separated file"), and it's not well resolved in dev-test.

in commit 392a1c419916 ("f2fs: maintain extent cache in separated file"):

- if (dei.len > F2FS_MIN_EXTENT_LEN) {

+ if (dei.len > 1) {

So how about merging this patch (f2fs: maintain extent cache in separated file)
first, and then merge Fan's patch? because one line modification in extent_cache.c
for fixing conflict seems much easier.

BTW, I have already fixed the building error in this patch, you can directly
use the last sent patch in this thread showed in below link. :)

http://sourceforge.net/p/linux-f2fs/mailman/message/34277570/

Thanks,
