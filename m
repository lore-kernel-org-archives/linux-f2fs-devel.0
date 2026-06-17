Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693ECD98F1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XtOhOYDMq4ryiLgqMgpcpL5mk1W4e06vOQ5tUMlONc=; b=L7oTbTPtV4E69zZgA9xD7EFX9Y
	ua6igp/lGvkl9Qgr4RNUNIeQEdyUCJXd1wI96P2Scm703ym0/b8LKCGLp51xzVsmA0JUPl+knULV0
	Yhs/e7vK3faTeeKOaql2hv9eAM10pwpRQgYjmsDsE4K1MfPegIw1Ej54m2QZX3uZwCXo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoLD-0004i2-Tf;
	Wed, 17 Jun 2026 11:21:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKr-0004gb-1b
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=11X4zN8yljptgUmegGLc9eRycZkJzLRPMfam5P0waQo=; b=ZMP3ktku/Y6eJ8QCH7tp52sLTO
 5lPqDj+JfS2VoAQ1HInz1x1gCck45xNwnpXljosuva4aQ0utonUQc0cZ22F4BWqDJ85+qCCT8C1tO
 tO80Iv4pugZkjlZwucfO8QLSk/F7FOeAjG85YnwCM4NOF3w6b4ZP+ykeJWqFfMD9D4RU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=11X4zN8yljptgUmegGLc9eRycZkJzLRPMfam5P0waQo=; b=Dh35C6LoSKTl3CaIyaUtShDETf
 Iw7UYRW6m0cptC8NMfVK02gxsg1Srgei0gg+Dx6KVXn7nVwJttAb7N5zKefbUSoq722boCSH0yQe8
 GIEjYCD2/uEQYFngnq2di8TKypilpoLkfJnV8B/TqI66jdFx3bvTmEIxay6rVeJ965ug=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKi-0002Os-Dh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B4DC60137;
 Wed, 17 Jun 2026 11:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED151F00A3A;
 Wed, 17 Jun 2026 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695274;
 bh=11X4zN8yljptgUmegGLc9eRycZkJzLRPMfam5P0waQo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Tx183UWBDcb6cM7UpbniLBQugwLMTY8ljaxB/fkfAkjoAfUDwpfzNUdZiG2oJHz3A
 7CvH7B1E1yZ7n3b2HqeHsM5uAvy/EuDWzT4mI+WPZXTfr0eEhUlwYCud8l7CcYd0kA
 AOL5JcczTKswRzsAkBqKBWYxHV/ff0dfNl2lTeBfxADirnqMMYJ/97qGlNsdwk+Brx
 IuhLlT3LK/5uP8GVJx2ipdjY23aUuExlOvkSEi8cTjRiljOnSEzesAmKO6dUfBm7E0
 01etGfC++kie4nh25uNo74GciHRYza5UJ4YRMwfVK+dW8Rf6Dawgi/b9a08RvwvrcK
 7wmxfnSptsZSg==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:37 +0800
Message-ID: <7a29c19695da36f50b0f65a617e7f328d7bb9611.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781694879.git.asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZoKi-0002Os-Dh
Subject: [f2fs-dev] [PATCH v7 10/11] fstests: add _change_metadata_uuid
 helper
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
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

_change_metadata_uuid changes the UUID of the golden filesystem before it
is cloned.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index d95eec94f7b7..5cd4e025293b 100644
--- a/common/rc
+++ b/common/rc
@@ -1533,6 +1533,29 @@ _scratch_resvblks()
 	esac
 }
 
+# Change the metadata UUID of the given device to a newly generated one.
+# Args:
+#   $1: Block device path to modify.
+_change_metadata_uuid()
+{
+	local temp_mnt=$TEST_DIR/${seq}_mnt
+	local dev=$1
+
+	case $FSTYP in
+	xfs)
+		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
+		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
+		;;
+	btrfs)
+		_require_command "$BTRFS_TUNE_PROG" "btrfstune"
+		$BTRFS_TUNE_PROG -m $dev
+		;;
+	*)
+		_notrun "Require filesystem with metadata_uuid feature"
+		;;
+	esac
+}
+
 # Create a small loop image, run an optional tuning function ($2) on it,
 # clone it, and attach both to loop devices, returned in ($1).
 # Args:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
