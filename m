Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA72C53200
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Td/ZGdBdp1fGM3CThC+OmvP3MG96WZbvMlt2hPSzKf0=; b=MU0hb2ZhnW/T/+wB+KLPV41+9z
	Fs7P0hNTf8d7Cjh0RNRyb7tq6kbEQOkmZn770O2c3XROb/yN8GhE4kDqN82ZLToN7VGmSVBZos5ke
	WCPkuTxDg0PulyXTdQ74s7gAMuymiYPW5CpDpc0W3Ym5XUumEuIC0gEs1K5EvTyIG2tE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp0vK-0007Ea-4h;
	Wed, 29 Jul 2026 09:50:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wp0um-0007DW-Dg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 09:49:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aVDAINXpByrQ66MLRoTWkHlTC6MrJnJ+AqRjvdfK4oE=; b=N/TU/w2KvIP/4kpnffXMwSf7Nm
 57hUKN8WmEpMPY2TTYPalwfu1szIqZgJ1RFMajgJbW3uBIdnGQ6RyKxTQEx6qo/LC36P92EsxBZ/d
 8fQ1lEMNEKuNuv+sKUzDTe78C3AGymlHExL1XpYF9izXYBGC0zCHV4seLa53AtOGZCgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aVDAINXpByrQ66MLRoTWkHlTC6MrJnJ+AqRjvdfK4oE=; b=T
 0cwMTYTwqF4L7+Ybmpbrux/TxOn0nVkuhXUd2GQerf0K1rSx4IsAk1/vo8u/tKiyxVYoD39IdhXHK
 9WCOI9DmxPsezWk4CYtYp2Z7A5VVWwONkGue3j12pupbpMHx3eVlQBW0iuhf72N2s7apITxcQvuUp
 RHx+DnJqnNBKhpsU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp0uq-0001jU-Ab for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 09:49:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2011560A9D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 09:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6451F00A3A;
 Wed, 29 Jul 2026 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785318562;
 bh=aVDAINXpByrQ66MLRoTWkHlTC6MrJnJ+AqRjvdfK4oE=;
 h=From:To:Cc:Subject:Date;
 b=PaXzav7ZMbqh44dDbopES8g2sb3BuXF45uiH22fILzLs+AWQQs2lffXZuSeoyWJsF
 xcs9CkonqSbdrs5PXr6mcw/BBNLUFH+LwnE47qKQfPplRKH/kmsklIWNtp0Vsm+kpk
 MfbufHeObY1aemIA4+e3TdJ6xIkjwzl6sN9mEySp7293+O10cRram35nWYtZYfFkdd
 7nguR8jY07teDRcbAyhO07cKrgjGZSWkKDXz9SQWO0zIlL+XW7jqDCNukQ2wt33xuC
 14oU3IfJTE42dLBUq5CDc13LmHa+bD23iiG8Fp0+KkfLo/PKXTVNhMAVr8RGtijpum
 Al67oUUVTJC2A==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Wed, 29 Jul 2026 09:49:09 +0000
Message-ID: <20260729094909.1499590-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
MIME-Version: 1.0
X-Headers-End: 1wp0uq-0001jU-Ab
Subject: [f2fs-dev] [PATCH v3] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs has supported to report fserror, this patch adds support for f2fs
in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.

Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- fix to chech sysfs node correctly
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 106f044ad..3a8f03412 100644
--- a/common/rc
+++ b/common/rc
@@ -6266,6 +6266,12 @@ _require_fanotify_ioerrors()
 		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
 		test -n "$x" && return 0
 		;;
+	f2fs)
+		local feat_file="/sys/fs/f2fs/features/fserror"
+		if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
+			return 0
+		fi
+		;;
 	esac
 
 	_notrun "$FSTYP does not support fanotify ioerrors"
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
