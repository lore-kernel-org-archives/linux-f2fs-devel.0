Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCB7CD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wkdvO85lrqvp3xtGp8ldBtAmVH85j6wPusp1iA/ynZY=; b=gmT+ARuqML0S2RTqFfdqaOH/gV
	qkAcpQxps+QdeqRcX9i2BT7ZCSKeUaVlNK5bn7OmhNwCkPjqM95aelbpy+i/tKm+Pm3s/W8cWdhGH
	OGY50cFHM4/ae7Cavu7HBCCA9Vjurk3p5DzqP9MkNItEFtfR5YrgxGP3oQVxnQkslqOU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfoB-0007hT-Tp;
	Tue, 12 May 2026 05:37:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfoA-0007hL-JE for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Hw3XcDONqEpFVCAFM8gW1FdoetT8Zbq83oYUzuqJBc=; b=YdNGmS/ccI0VNJMmQXLXCwzBvB
 0JL/6nCdyfCLKiniOjtPXkm1N7y9ujsUaiKSoZLIHFzkBoPOLaBKsLSPClQtDIe7tDrOkJ3GKal74
 aFJlS0o581IRILfWZJAsVA8P9Swvk0RaCmmVOSX4UISdLDr/SecY1HgAN2/RiuSX2QGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1Hw3XcDONqEpFVCAFM8gW1FdoetT8Zbq83oYUzuqJBc=; b=UBrdqRqeGkvCaC5E22mffToJ17
 xNBsVyavOXY0JNQ3YdmLBnxfVY+zUCy/1J/NO6ykgJEjazxD8+n8wqYqBSbzhvVvZ6/3mElQ5T236
 fNLXBbJF+A4T0WDUKkcGlbhyr5ChhTC1owd38VfXBWrwg+EDxDg9vq/PCBOWsg5i1WSg=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfo3-0004pA-P1 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=1Hw3XcDONqEpFVCAFM8gW1FdoetT8Zbq83oYUzuqJBc=; b=BKwVZyZBxahKZ8ZxCxPC6Y4z5Q
 pBiOEEqDkyx5ololy28vqASvBt4xi35sl0+NmWmVYePnVyQ72qbz3HwzDQq1AstWN25FRYsfZL4yD
 FMnezLkwXChwq9Lg8k2aBxxz9HNfyNtpVLv573yOfNZ/eB9CP1TIUvRVru5ciaKPe/f5DKPzFioOz
 mzDZhG9FVUkbzWZmxaJ/X4fLnz21zuNa5oGBY8gNbRmsAdW1dnnzK8h5NAlfUrt/sUDd5CmL8jRAu
 TerYktd4rvWR4hE8yA7w0bS2Amo/cU73MVg4bamNvnyv7oYMkUbHbvGSTZLjuwoBI1GwKcFyb0J6K
 aW1iSWxQ==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfnj-0000000FfJy-2bJw; Tue, 12 May 2026 05:37:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:20 +0200
Message-ID: <20260512053625.2950900-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfo3-0004pA-P1
Subject: [f2fs-dev] [PATCH 04/12] swap: restrict to regular files or block
 devices
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

Various swap code assumes it runs either on a block device or on a
regular file.  Make this restriction explicit using checks right
after opening the file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a183c9c95695..651c1b59ff9f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3515,6 +3515,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -ENOENT;
 		goto bad_swap_unlock_inode;
 	}
+	if (!S_ISBLK(inode->i_mode) && !S_ISREG(inode->i_mode)) {
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
 	if (IS_SWAPFILE(inode)) {
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
