Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F9BEFB81C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=odlApoRTZqbZ0mPF9BvtnMIkjf25mpvJIsHSQPTiFK0=; b=k+8EHjflYRs0GE/a/oBdDKjFZP
	PF52KbPApLz/3zkyFsfbz1yRJM7rjRRKit7cqHumBtfEktzWgJrYZPhIBPdhJ3cServ+H+YmFB8py
	OJqxQ6a6aFAji8+Z0Bqd/BZxMfoOFmsFVljI53lqaZQ2kE0lNQADvQqDKsqohhln+t6A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuvg2-0002ju-OC;
	Tue, 24 Feb 2026 16:54:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kth5965@gmail.com>) id 1vuvg1-0002jm-11
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 16:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+9GXa4UNt9CSm+kLhVLx7XY7ItraJjuFAoNvdJgLB50=; b=Z+svAxfmSIS8SejNQcidU0SNpj
 5+WDVhI344KyYWh0UMvSu9TbnxVHTpL2n+Xd0ufYkrFS7HsHjVmp19wN7LykMM7jsVOXxoZ59s+Tm
 Ier+uKYZ8HG9P1sAGoCHlm0r84tBS8Mrsw5pdBKLLj11ZGoyLQls4FTgMQ6xOhDz6EkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+9GXa4UNt9CSm+kLhVLx7XY7ItraJjuFAoNvdJgLB50=; b=OXnMkDcj6VAKrT8PprDNrNqGqZ
 b1mHt9d3hQFlZGoa2tlGpHIwM8DJBkvzuANioQOExF1VZJhh5JvcsYc8Oqitxxjp55DMRRB2WIB3s
 6a+9fQ6Qn5nAADqzU6uYxAb2VBhvHNn9FeMGlzGaXMebpi4yF9ZGzilSkVR0ScRkW1y4=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vuvg0-0000Vw-Ay for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 16:54:24 +0000
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ab1c8fdc40so6199625ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Feb 2026 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771952054; x=1772556854; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9GXa4UNt9CSm+kLhVLx7XY7ItraJjuFAoNvdJgLB50=;
 b=ClFtXql19vQ+GHgdFWfKM1GqrRlUsHYwLklF60MhMez4S5dftUT8+Hf/ep+DbsAtFe
 3h3Q+9RCLqz7+s4OrkU6qAaWNNMdqx/rONwLubmCF+HCF2NPAQLMtfKR82oaZ2PTNl4c
 LhEebF76e35pq4NXcvZhbj44eW3Tce8SbQzJ+1b4GJVu8lpoYx5lVOWbiSOjp0c4pYe4
 DXu7Clw19RXeVB7SZQ8zRZ1HLXl6O7B11Rw1zJcnJQd4RdVT9gYFLAi+AG5hYcwR6aWK
 7iTHA+RoPStfY6blXXpuertQo6htEx4vZ/+X1Stg7UIV0tuCklInSA3g5LgcVSR+wqOS
 zLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771952054; x=1772556854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9GXa4UNt9CSm+kLhVLx7XY7ItraJjuFAoNvdJgLB50=;
 b=xD8AaVt5eaSjHtseRTK3dDec902/8OhWsmqB+m0/IJAfhEsReRStFssc1/gmsxGTrt
 BmYS2e4a6VLmtve5i0XDpKBe8/plY6uHEyq+agBefxh1jYmGGvhTJeZ3OWAzc1KWA3zQ
 HUwk99o35rm0gUaXHMrw9sN402he5AzNag1zLXeCFuxmZDAFwQtMPUi8IXve7/wOgmL0
 zk+MisgJWABbdPfd/Fcvnl84x6HrkSavRp6V9A6RNMnxc9Ealolvv6RT7HK6CnA+ClY5
 Xsz9+tkjMAwu40FBPhX95I9r0ZH/gvj3Tqe1lWfVEbmajN3m4JSkrvKBuzGe1KDG3q3w
 akUQ==
X-Gm-Message-State: AOJu0YxFGHbYRhCmeaQM5JWmczQL5u9QPkZOFrd+ELq7wxxYYHSyhrnd
 oaxaWwtCrLkdIyjoQp1FJiqlNGmA3aB9W0N+Ca8SA1wvt9AJPJUJlgF3
X-Gm-Gg: ATEYQzxtezswO3r7VkMg2QMhhXlUqq3VXcrUfu2HExMsAmqp6bYkQE+Z0hTCyo8sG2K
 MI8Z+r/eY7j42gE28FclMLnCRSqb3bfIxBWGTqfeCguyJ9SoPAXtD+nHsR/4siabHaJHINP8oYE
 A3OZSgKT6PeVs6I3RewQ8fxxjt2EOXitQ4KLNlCYklrxEISkGFXrQGbqGPosmouXM2pZhukVIaY
 TxMBd1uekb34a58Gf4rny8YCUrX/luN8xtNQzxXStsYxh6Y0CJYMYRu/B3QfHlQX0sj2YFwzUQd
 FJrSsCb6AGRo+ZyBInFaT8tyt1R+HHB0/bJWO1Tcq0nlTfxnLiDa6xUQmaUI64MgVi87wmDXe6g
 0I9kReVoVkTQajSQAP+FW1BJYL8AJ9pRrXWAcne5WDW48/jr1viNDE7sJnPCUk190Bed86LRsN/
 mmdRppkT8usIgzZmPZGW6wbtQD6eXO4w==
X-Received: by 2002:a17:902:cf05:b0:2aa:de29:65c with SMTP id
 d9443c01a7336-2ad7452014emr85930935ad.6.1771952053477; 
 Tue, 24 Feb 2026 08:54:13 -0800 (PST)
Received: from kt5965-NUC8i3BEH.. ([182.217.14.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7505bf1asm112635745ad.92.2026.02.24.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:54:12 -0800 (PST)
From: Taerang Kim <kth5965@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 25 Feb 2026 01:54:08 +0900
Message-ID: <20260224165408.450957-1-kth5965@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224160654.448538-1-kth5965@gmail.com>
References: <20260224160654.448538-1-kth5965@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1vuvg0-0000Vw-Ay
Subject: [f2fs-dev] [PATCH v2] f2fs: evict: truncate page cache before
 clear_inode
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
Cc: Taerang Kim <kth5965@gmail.com>,
 syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a BUG_ON(inode->i_data.nrpages) in clear_inode() when
mounting a corrupted f2fs image.

I agree with Dmitry's RFC that dropping page #0 in f2fs_truncate()
can address this reproducer, since f2fs_convert_inline_inode() may
grab page #0 via f2fs_grab_cache_folio() and leave it cached on the
clear_out success path.

However, clear_inode() requires the inode mapping to be empty, and it is
hard to guarantee that the page cache can only be populated from this
truncate/inline-conversion path. Make f2fs_evict_inode() defensively
truncate any remaining page cache before calling clear_inode(), so
nrpages is guaranteed to be 0 regardless of how the cache was populated.

Link: https://lore.kernel.org/linux-f2fs-devel/20260206092958.578191-1-dmantipov@yandex.ru/
Reported-by: syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fc026e87558558f75c00
Signed-off-by: Taerang Kim <kth5965@gmail.com>
---
v2: rebase onto torvalds/master (fsverity_cleanup_inode() not present);
    fix patch context, no functional change.

 fs/f2fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e0f850b3f0c3..e7942e6e312c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1006,6 +1006,13 @@ void f2fs_evict_inode(struct inode *inode)
 	}
 out_clear:
 	fscrypt_put_encryption_info(inode);
+	/*
+	 * Defensively truncate any remaining page cache, e.g.
+	 * f2fs_convert_inline_inode() called from f2fs_truncate()
+	 * may leave page #0 behind in the page cache when the
+	 * inline conversion takes the clear_out success path.
+	 */
+	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
