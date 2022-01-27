Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB78C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jan 2022 22:10:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nDCyT-0001Lq-F6; Thu, 27 Jan 2022 22:10:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <konishi.ryusuke@gmail.com>) id 1nDCyS-0001Lj-Az
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jan 2022 22:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=; b=X3SBG9fVVptYYpy1Zy7JvdPxSL
 jKMAvGkcnyNWN6FqYDskydncYpNGamy5591J8Aqe4hrHYZT2Lf9fUavThT1/Q1w5/f1kOA+2l9BHL
 FAVJPC63Zr4EUVCdk3li3QOi+cJj/4ezvGUrypaJilMGkhLnTPlS041E1pJCG6RuuQ9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=; b=LKasHXHA/hes7LLBjAQ8e2dUnE
 FYZGqwtrrXs1pXfOkyiT7aJjZFqvQh1WzHNYEHIjavhAvsHuTmKwa3l8lSu33802mLChSxcNIqu2o
 vngNkYsggpc/18WoI5THd7gdpytZZL13ZnQZgDp6soM6EJ+4Wwffq/ZuNYaXiicE4pGk=;
Received: from mail-lj1-f169.google.com ([209.85.208.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nDCyM-00HAU3-6K
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jan 2022 22:10:34 +0000
Received: by mail-lj1-f169.google.com with SMTP id c15so6307626ljf.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jan 2022 14:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=;
 b=RZypLcBcYIUdWY9vV42TppO4LaQPblBv+kCbhi7sSIeity0kCuHxjxBkOW+017vQfl
 mGJzLUkiIibnMnTTVFBLt50VetVg1KzsVDl5jUao0XF5T7oAmS+N8pzAB7j2FNpZGYiq
 xbHy2XvQvsScldzehtVeFOoApJ3rHFqpSLvhJxxrFdkCY4SBOyNaqvrt+GIQFpxxuFFh
 CmyJh/SQOY6vLReOapEDPt77zxgz4JT8F/AZF2zWXE0KCoQ1ChkpEBN24khQj5g1i9qq
 aguCWoq8pgm51d0p5z0SrS13R+0j/TGLyIS5NFK+7PHw2xgpowySjWS1of9EUGPSq6jn
 /AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pkUjSb/fdfaa3FAu68ePw4JIYSvRfOC6qyjCilb3MLA=;
 b=3b3dqarPBueXigO665YeHqOKuZJrsbwcOre9/fspvnY3OMfsXKaRZ/L4RFMPMzIMK5
 y7aCySoShX+oqGeKqxPBJCzj+lZwTppnIzM3PVG+LKgQyzDE9cKGvqgKgnlfqp4Lsm1+
 fJdlm6SCIE9NbGBj545D+vPGkgY3ocVHgJDVmPAf+D40EgD8Ajk0vgbWXFneF53r0VmC
 zAwbjUDVF1Av0n/MDZOfi4NaPMwfxrrwqEIBxZy9Fk7+DeYp8yMZvWEEGz+gLEFCE5Wd
 GmBi3pQVrNfPOJR7Xbp0dPemf15ef52nEUssA0JOE7bbT92Axuvxq7A0sT/GyvoW9Ocd
 gYhQ==
X-Gm-Message-State: AOAM531hRZjOGSbQ2boZCaJNkDZcgWTQRHjV6dZ4BmuBw3/iBXzTSYPn
 8IUYR623xdWgL2kMweWtL4T501QgBDCMeHmlk1Y=
X-Google-Smtp-Source: ABdhPJy9dJl6L/bnRQi8tK1Am+5DPjPBZvatcTyLSMpbpD4vy19hTtp8mGF/Cl1TBx2f3Cw7TL+lgScx4mlljQ4behg=
X-Received: by 2002:a2e:5d3:: with SMTP id 202mr3981304ljf.330.1643321423317; 
 Thu, 27 Jan 2022 14:10:23 -0800 (PST)
MIME-Version: 1.0
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
 <164325158955.29787.4769373293473421057.stgit@noble.brown>
In-Reply-To: <164325158955.29787.4769373293473421057.stgit@noble.brown>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 28 Jan 2022 07:10:11 +0900
Message-ID: <CAKFNMom4Z76ti4fp69UeKYf0d4x635OR7Q_CjVnBj+vQSuhESg@mail.gmail.com>
To: NeilBrown <neilb@suse.de>
X-Headers-End: 1nDCyM-00HAU3-6K
Subject: Re: [f2fs-dev] [PATCH 2/9] Remove bdi_congested() and
 wb_congested() and related functions
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "Darrick J. Wong" <djwong@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, drbd-dev@lists.linbit.com,
 Paolo Valente <paolo.valente@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nilfs <linux-nilfs@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 27, 2022 at 11:47 AM NeilBrown <neilb@suse.de> wrote:
>
> These functions are no longer useful as the only bdis that report
> congestion are in ceph, fuse, and nfs.  None of those bdis can be the
> target of the calls in drbd, ext2, nilfs2, or xfs.
>
> Removing the test on bdi_write_contested() in current_may_throttle()
> could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> is set.
>
> So replace the calls by 'false' and simplify the code - and remove the
> functions.
>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/block/drbd/drbd_int.h |    3 ---
>  drivers/block/drbd/drbd_req.c |    3 +--
>  fs/ext2/ialloc.c              |    2 --
>  fs/nilfs2/segbuf.c            |   11 -----------
>  fs/xfs/xfs_buf.c              |    3 ---
>  include/linux/backing-dev.h   |   26 --------------------------
>  mm/vmscan.c                   |    4 +---
>  7 files changed, 2 insertions(+), 50 deletions(-)

for nilfs2 bits,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
