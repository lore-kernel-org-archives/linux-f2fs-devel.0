Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8642BC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AyH2/OLdocuXl4RdLj38n8x+jDs9U/Jmh+dSiKc3W20=; b=FXO9HDEqtxZFrtvAt6SJ8juOIj
	E+OkRdkNiBtyeYbFJIsOxN2pdiSfPRXpRxSLfRFXTKghBa+rUUnF4HzKo57qRIO7SKXCVgZBYUcmU
	GlErypz+DkPL9XrAN5188oLzJAd957hHaatMw7gjxSjCfngh/m6S76gtxLsPzf9RtdL4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzK-0001ER-No;
	Sat, 25 Jul 2026 07:40:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWz8-0001Dk-39
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sLqlpYfUqqnUXzeM6LLwXu0zSUkOzx/Ofan0xuQplQY=; b=JL6JDdVV/01S5veHtW9z8QkQID
 1xs6r2GeCRMqPmMpfRBMCgxHWaYVTACDLTlpGxDWm9rAC8AUVDTK6MlDpC5PqZe3iJO7lA+/3Pzow
 HWW7jOVp87x3EwtXtjp4VpIkZWGsmsZ3Za6ndmMQdS5PilQDY/HIvpFRCZ/9k3+8SEec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sLqlpYfUqqnUXzeM6LLwXu0zSUkOzx/Ofan0xuQplQY=; b=m+MWQfrfpyzZL+T0GAR0hcBt4K
 6JArneeqDZzDbBEFcBX9wveS0DW0hMMZD2C2pZ7frgbeU8dhoJlRJfzX1lP59GW5VUMrxenfamGaG
 IGGsglDe6vIAZL/Y2MIrhP8ZfZrxz6Y348gE3/c4tIZqGNm0OkfHrWnlVkTL7CkHPd7E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWz5-0001cB-7R for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0049600FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EB71F000E9;
 Sat, 25 Jul 2026 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965181;
 bh=sLqlpYfUqqnUXzeM6LLwXu0zSUkOzx/Ofan0xuQplQY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TpbBYwjxPGfADkXxk5469TxW8zfvfEKLdVGQDvUyxmKPL3ZU6nADeyl5k819QBZE7
 ObVZN1la+VUDtK5QgSrCGk4/77LrZq71nsQBnmKF5l7QSakVUdY8X1P8JMWExL+rzP
 vxpLM9GxygNfW85XZrCRc9baQTNJWbfIEgsh53g77UlHdvGkNZpwLfxxbOSERZ4lly
 sUtSiDqYe9uyrC1X+mMhHP/t0hej7VEhD4j2bQopWR0QgC0+eUm/RwMGYnYb5aQkKs
 P/C82IegjI9+qsw4vtZF0P16NkD7tABPil8QCWn7kWPTYfZN0furc69mvsR0AgiS+f
 aJpxVJKQRRLsg==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:39:01 +0800
Message-ID: <d8fb7f5c0d67cf01249e8fc4807e963cc1a353d0.1784949155.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWz5-0001cB-7R
Subject: [f2fs-dev] [PATCH v8 04/13] fstests: add _require_fanotify_function
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
Cc: zlang@kernel.org, djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fanotify support may not be compiled into the kernel. Add
_require_fanotify_function to skip tests when fanotify is disabled.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/rc b/common/rc
index 53e5d9d43af6..21b516accdf7 100644
--- a/common/rc
+++ b/common/rc
@@ -6329,6 +6329,13 @@ _require_max_file_range_blocks()
 	esac
 }
 
+_require_fanotify_function()
+{
+        if $FSNOTIFYWAIT_PROG 2>&1 | grep -q "Function not implemented"; then
+                _notrun "Need CONFIG_FANOTIFY and CONFIG_FANOTIFY_ACCESS_PERMISSIONS to be enabled"
+        fi
+}
+
 _require_fanotify_ioerrors()
 {
 	local x
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
