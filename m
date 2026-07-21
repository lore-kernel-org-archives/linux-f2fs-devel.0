Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E825C44537
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ma8tjkLhlpwZhUjd2qQfea5t6vT3XjEPacQZbUIS1wA=; b=DoU8rdPHtvmUZLuNUB3XK1q8oy
	+cK5PJBK2nRSpDCcXz7pKsYd+oFduhl4fOUU+uLxElniuvqoOeNb2PIijp/HkEdHjDvzMu5vX5GzH
	p5erZfOhctUlOKgAT86qjHUaMWTQfE8iITQSi9FOt6Zb7FsuF+G+StPFdO0wCxb5I10U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSl-0001mL-TJ;
	Tue, 21 Jul 2026 18:45:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSg-0001lU-TV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=; b=WQoB9bRqkFI8MvAhWmGi4cksUu
 Y1vaIY0MaD6wqCD3htGPlNNKrSG9k359IKsDomKzYU4cVkncTzJocuGGtx24XHe9XaeUfp4imqfZ0
 LnQjXSJ9TFsg3oH2RHo9wjyWB04hDiTevdaj8fsZH4aoderf7UGGqolh9tYYNmq0L+9Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=; b=HoHI49EeeGWmU37EkyYQOD1LJW
 EJ+wa8R6jc71ErTs8Yg6sPaHKm2tlEaG5raJ7wlkb1zWty7i7MPWdYlHWWuMGtkitqvbZSqSpZm8f
 wGFDGAvyoNVAH8+P+WWNsCg5wB7iC7lhQ5hBkatrmTKk8uNBZa72EFhBsPpQfPaZt1Xk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSg-00033w-2Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:45:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 718A760A65;
 Tue, 21 Jul 2026 18:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C2F1F00A3A;
 Tue, 21 Jul 2026 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659491;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iW7vr4CG704dDO1eJ6g5Ch8UJjFWpSsoSFkgoQ+bVXjgo29f3LJf0pLe6wTQjwif4
 VqSKgGqXPMmotm8lMNpGKsHn5aazwu6ust4ofhSSUOOOoaVLfhsbrNHjW5Saoey6U9
 d3+X47aJXNtIOUoBfj9BjMR8V4xRD/Cs43OapqxYMaJUQ3RoRwf2W4QcC5OkyNd3Gg
 yi+e9slNN5vTZUEpjV4/AAe9VVK8wY0p8zUVW+fykjpe660JKD9R4GOh+kf/mYI9xm
 ym9rfK9/gzmFKOYv/ayqQCM13/x3xixp4p+HIA7URXAeRNpcF1db403+R42BSxaMFG
 AsvI+AwyXtFmw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:56 +0200
Message-ID: <20260721184346.416657-20-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSg-00033w-2Y
Subject: [f2fs-dev] [PATCH v13 19/23] xfs: add fs-verity ioctls
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

[djwong: remove unnecessary casting]

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1b53701bebea..fc7860a8b5ab 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -49,6 +49,7 @@
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1466,6 +1467,19 @@ xfs_file_ioctl(
 	case XFS_IOC_VERIFY_MEDIA:
 		return xfs_ioc_verify_media(filp, arg);
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, arg);
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, arg);
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
