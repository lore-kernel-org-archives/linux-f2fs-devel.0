Return-Path: <SRS0=+7CQ=U6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C06FC0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2019 18:27:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656B621721;
	Mon,  1 Jul 2019 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gGe2m6Uc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ecxZDarc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQxxnHv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656B621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hi11X-0006DD-NC; Mon, 01 Jul 2019 18:27:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hi11W-0006Cx-7p
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 18:27:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3jVv8TsQ7LrqjiSsUpcZQRg98IvUIFfstxp03Q7SwnU=; b=gGe2m6UcCz1fqGQqqlDfvADFee
 cJG2FNqlb1KZuqNMtnVt2/1vd9KQw0N32a7pcsP8qZHLI17QCG8DWXlhqxQ5CdOEJ6mQ4TFahRMSj
 fIWottIPYIF0bgpqs1bwiAgGdGWNqSGROmyihY8wKV71uPFTYZZylzDY3Jsn0za41QkI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3jVv8TsQ7LrqjiSsUpcZQRg98IvUIFfstxp03Q7SwnU=; b=ecxZDarcv4W78lNJNvWyn7rxIu
 +g9uO0DZiih46gAOnTekwsOfgOFov9eSpznJghbqc3MS5ud+wMvZ0Z1YRqQ+w/NaJq2pJyCR/+Nys
 wG27+qh/uMdAjGgbzQDRAiyYPj4dMf89QQPKceilOfX5mnUSVS0fqmUktbORrxT+gTWk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hi11a-003KzU-Db
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 18:27:35 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2A0A2173E;
 Mon,  1 Jul 2019 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562005648;
 bh=/TqjxXaacZLBl0M7a8866fUvjTCYt+qsAku09GMwzaU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dQxxnHv37PKpFTpe8HW/se53kzv2A74FRRJO7BSy/a5dyvDMNuJrBMDsVO8W0NWUB
 JHKyMofa2PmzzQfBIwHsfTqtGv2KnbDstYHG4UTyPTAha3d9pfK6WCvzhZnqKNFUXP
 EZA20sZJxUFH5y3OMwpTwzqY7+Y+7H4LjaHU0mmc=
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Date: Mon,  1 Jul 2019 11:25:40 -0700
Message-Id: <20190701182547.165856-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701182547.165856-1-ebiggers@kernel.org>
References: <20190701182547.165856-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hi11a-003KzU-Db
Subject: [f2fs-dev] [RFC PATCH v3 1/8] common/filter: add
 _filter_xfs_io_fiemap()
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Add _filter_xfs_io_fiemap() to clean up the output of
'xfs_io -c fiemap'.  This will be used by a function in common/verity.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/filter | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/common/filter b/common/filter
index ed082d24..9ad43ff4 100644
--- a/common/filter
+++ b/common/filter
@@ -541,6 +541,30 @@ _filter_filefrag()
 	      $flags, "\n"'
 }
 
+# Clean up the extents list output of 'xfs_io -c fiemap', e.g.
+#
+#	file:
+#		0: [0..79]: 628365312..628365391
+#		1: [80..159]: hole
+#		2: [160..319]: 628365472..628365631
+# =>
+#	0  79   628365312  628365391
+#	160  319   628365472  628365631
+#
+# The fields are:
+#
+#	first_logical_block last_logical_block first_physical_block last_physical_block
+#
+# Blocks are 512 bytes, and holes are omitted.
+#
+_filter_xfs_io_fiemap()
+{
+	 grep -E '^[[:space:]]+[0-9]+:' \
+		 | grep -v '\<hole\>' \
+		 | sed -E 's/^[[:space:]]+[0-9]+://' \
+		 | tr '][.:' ' '
+}
+
 # We generate WARNINGs on purpose when applications mix buffered/mmap IO with
 # direct IO on the same file. This is a helper for _check_dmesg() to filter out
 # such warnings.
-- 
2.22.0.410.gd8fdbe21b5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
