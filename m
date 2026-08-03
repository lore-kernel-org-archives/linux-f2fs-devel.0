Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5941AC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ma8tjkLhlpwZhUjd2qQfea5t6vT3XjEPacQZbUIS1wA=; b=SE/vuG/VroXwL3hRMqeDAj3PPB
	QkT8X+KEvFIH973FSuukBv/jeq4UP7xXUViuYpPdRYS+G3zMb2uImRIlp7aj0jOrbfoR4kiXBKey/
	sGWbT0arwvkaJnQEABrnwPYHmSErHVchEZQ99+q4Sw6/XBaBWbK/oU0G+EGcGuVnBbfw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyz8-0004LR-3n;
	Mon, 03 Aug 2026 20:10:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyz6-0004L7-Ui
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=; b=jH5MQI27Ql+E49O1+o1HDqVZui
 5zfhuKMHokKYHACru4JOg/NfeyV7MqydwXhyr5hPRch46+2zS5SHzGo/8rapYb2zFhWJBzIsFlO9Y
 f02Qau895jDEVHZMPjkGcilw/T5EIudY9T/qv7Qs6UHfCElLCEvlvivFPEdFAV66NN2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=; b=f9S7GqYaJiqBLOdWUQdadTweYA
 oITrIvf1MeJWFYnfWOerhWTVfFpwXdCCITSlgSvelUAkPFvci4+ebW8+wItN5oc4GAUZEtkgcpqKZ
 yhJdhpwBc3hCVetiYUA+ebZ2Yo0qifRJ0TXmXClSGrxyE5fISzgJXsnR6ikHA8o9b1tM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyz7-0001EN-9g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:10:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5A5B60AB0;
 Mon,  3 Aug 2026 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA27C1F00A3D;
 Mon,  3 Aug 2026 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787799;
 bh=dse18FWQSUIoP6yquYEBISwJ2j8wLduiXGfJxJRjVuc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JGrjjPeBqoBomI0FnqUUAOZbXZ1ILjTbKhgkYyNGC5d5PFY1qAlmAp0ZvKM7oKiq6
 Jk52r2hsVctNjtaTZzdBf9pZ77z7BQcgq9FQoIOIfHFVUoY78DZedjSmIUclsv/0UF
 cOj5bHdTM40SvO3yD8pKzBhiff5Rh26wxLfGWRtb1CNHZk4hHC62enCdpqf2H9VSBw
 Qh7Uz47nzUf78OZFrfPX25OK5z8LxRgHzLyROdg5MvGZj/hBdAfFWsW7XT8rOLPzZI
 tk+0iWSxynD9q2aM3cY5p8X52FLvtvRQhz7SSbVjOW8Ye2uVJTgJAS91TbBNPJRmQ6
 jbeam8h1tXZOw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:08:07 +0200
Message-ID: <20260803200820.393203-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyz7-0001EN-9g
Subject: [f2fs-dev] [PATCH v14 17/21] xfs: add fs-verity ioctls
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
