Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E996C43465
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:35:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D2D2070E;
	Fri, 17 Jul 2020 01:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="GPlgZNkC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JglXTmF+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="egSGITx0";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="oxCwlxw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D2D2070E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=to95fzJO7SD4NPoyVQ5HV4xEjhhcJ/wxTpC23tuX9TU=; b=GPlgZNkCNxEY+PzoOZOeZ7Stk
	yjRiB0JDmv+kP8rd7/5K7ELYcq2efqYYDgQnDG5JrPDWFnZluv5XkYKvXZLoxN6ei96ZglblTbGKc
	qLgusbKH0GIBJ6JbZR+tzR8ALZvW1navNRSWtqcxRQ3eMzOswOx/X9eqwZilvVgFRsVqs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFHx-0001sN-36; Fri, 17 Jul 2020 01:35:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3ZgARXwYKAKkbJchJcPXXPUN.LXV@flex--satyat.bounces.google.com>)
 id 1jwFHw-0001sG-NR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=; b=JglXTmF+UT9YkgsC+mgqFu215
 LxqlYhHdPd2aYyEJFO9QoS5wH77Au+cAz6HtZHEAdkMCAII7pLAcLNBxVQS3iyAB+fXTMZH/ezb2b
 FUrXthUxebZmcitgV1b/38htCvZGjAvsyotQEd1OYmT4zY4SCLqTU3QjJrXE0SM5FCeXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=; b=egSGITx06schHMjhjo4rxX6BQb
 115j+7I6Mj8KbsCsL4DufwP8znv/ryeLwI4SdDK5C6h0LLqNNJT/vPZ4nICQtEbePk2M2I03Wh97I
 DUPrnxoJNIRy6cuXdL7n4wkV+elg5BPgt37daQ57jyVXF8VKVFLI/sXdcV4DYpRitKlA=;
Received: from mail-yb1-f201.google.com ([209.85.219.201])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFHv-003lFn-Ci
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:35:48 +0000
Received: by mail-yb1-f201.google.com with SMTP id 124so9689907ybb.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
 b=oxCwlxw8hiOmpc9dDE5VHP0nyw8uhX2w43IaKudLEwrXxdgnP120llEreKyOOyh1yb
 1WL8Dz+vf62oDSYhDCJMemrgkfz8WYWqfwvE/k3RuBACwKsg9UN/b/70jtV8Bh5s5ZUl
 WrqxtcHQKHwvgHTdS5R/09Di9WRfeq7aFwIAp6PB4QWEH0TDZQQYq6ccRf0UpNNMbFFl
 k4ZGdek4wV3r5+sTAIYfuP/jWrOw9Pbl+P1VkdzDRNqXM7DL0BJSJwO91JPyC0vA5ApC
 ngAIgB1BKgaFCSFN5dAUqxUK11W1Cw9dSBzo0il3J6r3PmLNgtmOY/hVfrka9zORhpXj
 ZLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
 b=lCTrpnfsLm1gc5HCh2K8Bnu4qpIjEOEttXVRPj6wwc0DggO1FgFnC7kWdyGuTVJxrJ
 bWkmbFwuZFBfOBxjiXKnB+guSWuBaoz2iTLqQy6SL6rAVGVgrCrQwPK0V1Rbef0tteil
 euZIpwbYNa8CXOu9hnMXNRhGiKx7KAn5iRkg60ZkeefdEeMcvsvBwVGrjUYQ6Ce4lOqr
 W7HkWLXYHjOdW7gxFEDCkQVPiHL5mYQzR8u+vfoswdGRKlARoybxbdeLnj1tixM5QrsZ
 m2TYq/OP87WLAWywPBjR4ABwS9ZDsJL3F6stakAewPhrj9joOmrFKXzIRtzgyZ7R9OKB
 8/5Q==
X-Gm-Message-State: AOAM531iku83AVMkyesvGmhpXKlLF8+nLPcjy5Hzv8TD7Ya2RhqE/RlP
 OsX0Gom0nGNbpo2za6FgaQIQNJhuSYw=
X-Google-Smtp-Source: ABdhPJwyL6R46WRxWnDIfZEHMgiK0bcZUjuux5QdiBW2epiAYbnHUX5h5wXX6tXlXwwrx+N2jIvS0DNsy54=
X-Received: by 2002:a25:e790:: with SMTP id
 e138mr11127098ybh.114.1594949734407; 
 Thu, 16 Jul 2020 18:35:34 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:35:16 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-6-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFHv-003lFn-Ci
Subject: [f2fs-dev] [PATCH v2 5/7] f2fs: support direct I/O with fscrypt
 using blk-crypto
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..978130b5a195 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4082,7 +4082,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
