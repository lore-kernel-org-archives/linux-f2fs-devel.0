Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB4CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85HhHDxuPfZg2+wrDQQdYCmy08xnlukte63eWcYv/08=; b=S8aMK0/wG9IHS99c+Z2PDHYpJh
	/JhqNOeyud8Jt3onNztiXVmOxvcgI0GygJ4t3lDBEp0eC/n75jN/jKiSQ5YuWa3t25iF/Zc0Kt9kM
	pPcA1bn4k5D+8pUYl+uyhgEtiGuosff6KfqbmJFOqdztPlI3FeQ+cYz+UmGHgCacateU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yZ-0006mS-3i;
	Tue, 06 Oct 2026 08:56:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yX-0006m8-2O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gyagzCFzfR8NXrj8ArDpU5SoX4giHOzAJxEfd06R/sc=; b=WV+lSs6Um2NWzS02h/MXOWfTaL
 s/jbU+h+ykm3Lvjusc/47DL9EfsiosBnDGGF6UqIw0iPd4Lxil0zPrL/ZUGhk72Pc5BLcsEL/yI4v
 AUMdO4SbVJdFUP0DnJelirQphTncmFXlQnrw0+D1UM6AxPQ2Kmj5uZt2s31cclI3a9Ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gyagzCFzfR8NXrj8ArDpU5SoX4giHOzAJxEfd06R/sc=; b=M534X7AE00g8QQ2q24tjDGxNcD
 rMsTM1StuU0Rx6T78ZpomWv5FsiRvI+AIh9+hxJ9t4z+7/r180iPMppKEvYlRnuCxtN0fhd+j2PT4
 YhdywaKFclBrDCw4qkzf3UIaG2BI5hvFX5Ch1UZ7LLAg2TKZcWZlS9FZ1IeVdXqWfQsQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yU-0000Li-52 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97979602D3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A561F00898;
 Tue,  6 Oct 2026 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276992;
 bh=gyagzCFzfR8NXrj8ArDpU5SoX4giHOzAJxEfd06R/sc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BualXTilDpMmacU+nIUf+jMyv28iuEyWHfqD1JDs/+PK01kJRqYhkEEKpRwdvMtGI
 /bg0bBYZWnI2SGNMb3IsZ64Qqr1UfJsKBH8x03j6vGltUYNX2BrPjAZeDg08SdWjrf
 asjHGQyppjtPsowREyDY4UVp8v/H6jFCjj/myAuC8rbUtV2Pb7oiGmn8y8Q+SSX8Qn
 6+J90Gx/Sx6lc8f5PvHrPW94Z/Branm7y+YLUmSsF97AsFJEukviGN8qEJG0AAfWyy
 gw1MIhKkt3AOlhLbinpsduIqr8HA93/WPfuSuAK9spotN2UJNeLF3B8yLiKywZemN3
 Djml1RGbQvekA==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:35 +0800
Message-ID: <5a816f5c76ae3e0761524d53998afd9d0d74f58f.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yU-0000Li-52
Subject: [f2fs-dev] [PATCH 09/21] fstests: introduce helper
 _scratch_mkfs_uuid()
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

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/common/rc b/common/rc
index 37b32b498c80..37df780f64ef 100644
--- a/common/rc
+++ b/common/rc
@@ -1449,6 +1449,36 @@ _scratch_mkfs_sized()
 	_try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
 }
 
+# mkfs filesystem with a known uuid
+# Input argument : none
+_scratch_mkfs_uuid()
+{
+	case $FSTYP in
+	f2fs|ext4)
+		if echo "$MKFS_OPTIONS" | grep -E -q "-U"; then
+			_notrun "Config contains mkfs uuid option"
+		fi
+		MKFS_OPTIONS+=" -U 12345678-1234-1234-1234-123456789abc"
+		;;
+	xfs)
+		if echo "$MKFS_OPTIONS" | grep -E -q "uuid"; then
+			_notrun "Config contains mkfs uuid option"
+		fi
+		MKFS_OPTIONS+=" -m uuid=12345678-1234-1234-1234-123456789abc"
+		;;
+	btrfs)
+		if echo "$MKFS_OPTIONS" | grep -E -q "uuid|-U"; then
+			_notrun "Config contains mkfs uuid option"
+		fi
+		MKFS_OPTIONS+=" --uuid 12345678-1234-1234-1234-123456789abc"
+		;;
+	*)
+		_notrun "can't mkfs $FSTYP with uuid"
+		;;
+	esac
+	_scratch_mkfs
+}
+
 # Emulate an N-data-disk stripe w/ various stripe units
 # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
 _scratch_mkfs_geom()
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
