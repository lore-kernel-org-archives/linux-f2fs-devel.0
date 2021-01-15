Return-Path: <SRS0=/NUP=GS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE5AC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Jan 2021 18:30:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C65823A9C;
	Fri, 15 Jan 2021 18:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C65823A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l0Trp-0005YW-G2; Fri, 15 Jan 2021 18:30:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1l0Trm-0005YM-US
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Jan 2021 18:30:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GkawqntyBDEXWEQlgwobjOWrXsTUaP4BxzZ9ewFI4dQ=; b=MUlFyR1bb7Pr2+K+wE1YuiL19W
 dHplpgMWo7Hknade7H155lbFlmui3nWvd7PECi56piqaI6InkEpOGSWFbrNeoHv8rEoBR5x4HWrZ9
 IO51IlNimAZZm6x7Z7zTYV/dE6gXKhT/4pE1uFcjgSa/7fV9HR4D6zF2ywCC0wq2ZFoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GkawqntyBDEXWEQlgwobjOWrXsTUaP4BxzZ9ewFI4dQ=; b=PgoaKTKRlJHXhurdYTVPlEGkNO
 oRaPEKsUR9i8Q1TnvTd/H39PevCqWxwW3zU2F1adr1KgC71/fkrnAkHsroW6tr7D8UjHTiqn8O5Pt
 /xvT5uh3GyB6HU5l58QTvphHvzCPkQWepZYe8q4C/0zpPblgNiga5yooM/TJyv3Wqpvg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l0Trd-005QcY-Qb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Jan 2021 18:30:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45C5923A58;
 Fri, 15 Jan 2021 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610735420;
 bh=OlnfKFkoxSsw83/Nn4nLPOmT1fppOZvKCzhP/LtAIl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t/O8dyvApsG/tAs049qpWPh34uTtY8zTJEtQe176sA4nna21Mz1l6QhUo2LUFQuwN
 m4BeX8w+ZP+QvKvz39MUWoOk8FtWQ/gdztA+SXheMn1KIN7J7KQImiNRu6PFReI3E5
 OSD82W/izCrxFEUXEkfYpnK0lD0YklHed3ff43G13izvGG1iA7YtxFwULaWIWNvTwg
 7mqfiHlRf3Q4qiIxZ35GBHZ6ykdpwnyCPZz43i6IoCGsIQygMe4a6h9IN6XcuqB0/Y
 9HQPn79xSztl+3Vdgj/hw7DFDCX2s8daIBfu0xDkLMN1hHWJEXM3Y974ap7nbjfRhb
 ZuG/QL1S4cp4A==
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Date: Fri, 15 Jan 2021 10:28:35 -0800
Message-Id: <20210115182837.36333-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115182837.36333-1-ebiggers@kernel.org>
References: <20210115182837.36333-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1l0Trd-005QcY-Qb
Subject: [f2fs-dev] [xfstests RFC PATCH 2/4] generic: add helpers for
 dumping fs-verity metadata
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

In common/verity, add helper functions for dumping a file's fs-verity
metadata using the new FS_IOC_READ_VERITY_METADATA ioctl.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/verity | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/common/verity b/common/verity
index 9a182240..38eea157 100644
--- a/common/verity
+++ b/common/verity
@@ -120,6 +120,27 @@ _restore_fsverity_signatures()
         fi
 }
 
+# Require userspace and kernel support for 'fsverity dump_metadata'.
+# $1 must be a file with fs-verity enabled.
+_require_fsverity_dump_metadata()
+{
+	local verity_file=$1
+	local tmpfile=$tmp.require_fsverity_dump_metadata
+
+	if _fsv_dump_merkle_tree "$verity_file" 2>"$tmpfile" >/dev/null; then
+		return
+	fi
+	if grep -q "^ERROR: unrecognized command: 'dump_metadata'$" "$tmpfile"
+	then
+		_notrun "Missing 'fsverity dump_metadata' command"
+	fi
+	if grep -q "^ERROR: FS_IOC_READ_VERITY_METADATA failed on '.*': Inappropriate ioctl for device$" "$tmpfile"
+	then
+		_notrun "Kernel doesn't support FS_IOC_READ_VERITY_METADATA"
+	fi
+	_fail "Unexpected output from 'fsverity dump_metadata': $(<"$tmpfile")"
+}
+
 _scratch_mkfs_verity()
 {
 	case $FSTYP in
@@ -157,6 +178,21 @@ _fsv_scratch_begin_subtest()
 	echo -e "\n# $msg"
 }
 
+_fsv_dump_merkle_tree()
+{
+	$FSVERITY_PROG dump_metadata merkle_tree "$@"
+}
+
+_fsv_dump_descriptor()
+{
+	$FSVERITY_PROG dump_metadata descriptor "$@"
+}
+
+_fsv_dump_signature()
+{
+	$FSVERITY_PROG dump_metadata signature "$@"
+}
+
 _fsv_enable()
 {
 	$FSVERITY_PROG enable "$@"
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
