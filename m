Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15849CD4F24
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ByGiSAj/aQj3L0I2rA8b40cGf1p1l/OYsivgTR0yKok=; b=JC6TVQsjROxbAihQs/5LNVdjPy
	zsxN7oyl5QROGojmB7tWmeqQNLxA0FCOSRfPv1uVKD7N55h8uTBAoyfMPqIRwM680y0ml5H+ak0Pz
	8AeZP++6kILxgtwA59plROUca+QVZsdjhua5qvuEtrcMVBZH6Al2wYXwlwYnDSXUti3o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfnk-0007Rb-6m;
	Tue, 12 May 2026 05:37:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfni-0007RI-VX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L6G3lv4jbdMbQ4QsNCiCXE8kA9OQYRVEnsOclxNjvlk=; b=XWf9rnClI0xC2u6uscgFLa7dtO
 4Fpi/S5NKyXTQ8CrIeMHZRgLvnB5AU8Z6Ykzwz5SVLP8MvHHJhMBoYtErGbOS27x0hvkDgIlhH4KJ
 yxyVCzC60k2sxsKS1y2xMK/7vv/+taCrggA/KDVSULSdgjMjNPD0e5lzMDaN0my7PTQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L6G3lv4jbdMbQ4QsNCiCXE8kA9OQYRVEnsOclxNjvlk=; b=A
 ocuRveuJeKsIFh6+weckrzlDoJHiTPD2Z5ZdNyXovbBua8QvNgUjzJOIx0CRbvn+iKDNN6KwnOyY0
 MYU/0JxKc1b3/LdKyDQRJGeJkowPkYshmA5et2mGGZvL0f9jT7601cOlaoBqWzdMax4KJn8oQIucj
 W9l+bb6X5ZVV+qb0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfne-0004nW-Lo for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=L6G3lv4jbdMbQ4QsNCiCXE8kA9OQYRVEnsOclxNjvlk=; b=KIK+jQvSnKRXIFRrePcKSt8tSC
 gTDIoVa3ilaBJgAv2JyiBq1oBQNEEVuR8cAKQZACHFbXeQgzOq5bCCS43yMoo3rZpQpygSiDzL+5p
 k8ewxMk5abPknkbI0BLQkk18U//bp1Se74dgd8ytTOIwgIqIRD8+j0upZnmtm9RP/nG0Iay4iv5BI
 0R0Ux2iGn5C8GSW0QkgvHRpchKQA0HU/3surCqZ+w6g1XBcpaQIEofBGAUjsWIOw9fW5TdRUHOoZH
 pIElcotsE4NXj4I4GC6C78nmVfU4K8GqhWK2VIAj1M/0+2fkttDIMP1Vqdy9WFOxCQtHvlSJJWz7z
 NqzmFnXw==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfnF-0000000FfDa-0NfM; Tue, 12 May 2026 05:36:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:16 +0200
Message-ID: <20260512053625.2950900-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfne-0004nW-Lo
Subject: [f2fs-dev] improve the swap_activate interface
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong " <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi all,

Darrick recently posted iomap support for fuse-iomap, which was trivial
but a bit ugly, which triggered me into looking how this could be done
in a cleaner way.  The result of that is this fairly big series that
reworks how the MM code calls into the file system to activate swap
files to make it much cleaner and easier to use.

I've tested this with swap devices manually, and using the swap tests
in xfstests on btrfs, ext3, ext4, f2fs and xfs to exercise the different
implementation.  Out of those all passed, but f2fs actually notruns all
tests even in the baseline as it requires special preparation for
swapfiles which never got wired up in xfstests.

Diffstat:
 Documentation/filesystems/iomap/operations.rst |    3 
 Documentation/filesystems/locking.rst          |   35 +--
 Documentation/filesystems/vfs.rst              |   40 ++--
 block/fops.c                                   |   15 +
 fs/btrfs/btrfs_inode.h                         |    3 
 fs/btrfs/file.c                                |    4 
 fs/btrfs/inode.c                               |   72 -------
 fs/ext4/file.c                                 |    6 
 fs/ext4/inode.c                                |   11 -
 fs/f2fs/data.c                                 |   50 -----
 fs/f2fs/f2fs.h                                 |    2 
 fs/f2fs/file.c                                 |    4 
 fs/iomap/swapfile.c                            |  165 +++---------------
 fs/nfs/direct.c                                |    1 
 fs/nfs/file.c                                  |   21 --
 fs/nfs/nfs4file.c                              |    3 
 fs/ntfs/aops.c                                 |    8 
 fs/ntfs/file.c                                 |    6 
 fs/smb/client/cifsfs.c                         |   18 +
 fs/smb/client/cifsfs.h                         |    3 
 fs/smb/client/file.c                           |   16 -
 fs/xfs/xfs_aops.c                              |   48 -----
 fs/xfs/xfs_file.c                              |   39 ++++
 fs/zonefs/file.c                               |   30 +--
 include/linux/fs.h                             |   11 -
 include/linux/iomap.h                          |    5 
 include/linux/nfs_fs.h                         |    3 
 include/linux/swap.h                           |  129 +-------------
 mm/page_io.c                                   |   45 ----
 mm/swap.h                                      |   92 ++++++++++
 mm/swapfile.c                                  |  227 ++++++++++++++-----------
 31 files changed, 471 insertions(+), 644 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
