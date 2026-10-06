Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A915CA5FFF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXa3R1gn8sxLL/fWH7zG+VDADipg00YALOmwwxlKflw=; b=ZDubCvIxPKioWdG7NWs7pU2VEi
	60z2KU1ZdFEFgUFGFnXFTJsBQWXvOBEKgjeesfogiseFvu5uykZ/iA4h+91Ic0CmaBNItBA3Bh0SA
	g4nK4Z6BnahsfbeTI2+Ff/vWvskvXARGYRVFo7i6Za92biNlFXp+oJVPbcsaa+XQGwuE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yk-0002CH-EL;
	Tue, 06 Oct 2026 08:56:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yi-0002Bl-NJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g3NivwYtKychBBE/sjOAVqN6lB06fYWUGYDB0w33HwU=; b=JK7IksFapXHJrE+c8pGJZ0ny2Q
 hfSJpaev8d7Y/avKG8wmyj9W31tWtSoRtJZT/n0i3Qq8QgEw46mTF6UHeeIoxjIpZNCTS/Oeq5w6m
 Hwaqwdz3Ro7SsLP6ggzHypNb847YfMpsw1IhCI1yq0FKJHwJI4v730hNJSHQLtMXKSeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g3NivwYtKychBBE/sjOAVqN6lB06fYWUGYDB0w33HwU=; b=V3VNwWfbAKbCIciUWVTNumM6w8
 wOf+mV0XpwFSqWydH0vbYfV9kxsR3L65nO0NneiOGjsgpmjCw0Omiy9hTKdsDYpymuC5AjiFx5NGo
 Jr1VTSmd0qE/WNg3/IxgKCgeuaYVdogHOdwwE2kVtpHbJJGe7FLTSggE3F7jPUu2sx6U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yh-0000Mi-SU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95C61438E7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC541F000FF;
 Tue,  6 Oct 2026 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277006;
 bh=g3NivwYtKychBBE/sjOAVqN6lB06fYWUGYDB0w33HwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O+G+FRX5Sv0gykhSgkc8ayhUjpBkjBQeuz/3F4oupNm6H+8k3EZQSulQupdV2nqyS
 EU3qzWciagLGbbTYuVUJ/oe8dljDus0Pf/9VeBzrydMgGJ29aY78Xm6MNE443y5rXj
 ObtrElfMzN+ZtE2+v3wh9FNn2/ZwuIrjhgDJe9OTeveGwp59xKx/NP0mYXEb96D57E
 WdqKmeRH/+LIikAvTPaV6xkz6ui1sDUJtKngQIHAuoKJQSWKU6HGtlrwD/+f1/Dsbw
 TGhrtvjzZbhq4rA37tUC1zb7TOD20ZqVJKPW6z7pACN35nxX7cHHjiWeP6aV1vJasL
 R8cdjwju37lvQ==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:42 +0800
Message-ID: <2d4f4228bd376e234425fd2b23692820593486a4.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yh-0000Mi-SU
Subject: [f2fs-dev] [PATCH 16/21] fstests: introduce
 _require_metadata_uuid() helper
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add _require_metadata_uuid() to common/rc to check for the required
userspace tools (xfs_admin and btrfstune) on XFS and Btrfs, and verify
kernel metadata_uuid feature support on Btrfs before testing filesystem
UUID changes.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/common/rc b/common/rc
index 4ae3c74a52cf..bc0522dbcdd3 100644
--- a/common/rc
+++ b/common/rc
@@ -6527,6 +6527,24 @@ _require_unique_f_fsid()
 	esac
 }
 
+_require_metadata_uuid()
+{
+	case $FSTYP in
+	xfs)
+		# The xfs_admin utility is required to modify the filesystem UUID.
+		# Kernel support for metadata_uuid has been present since 4.16, so
+		# it is assumed to be available.
+		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
+		;;
+	btrfs)
+		_require_btrfs_fs_feature "metadata_uuid"
+		_require_command "$BTRFS_TUNE_PROG" "btrfstune"
+		;;
+	*)
+		_notrun "Require filesystem with metadata_uuid feature"
+		;;
+	esac
+}
 
 # Computes a percentage of the available space in a filesystem and
 # returns that quantity in MB. The percentage must not contain a percent
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
