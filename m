Return-Path: <SRS0=icLK=M4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE85FC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Aug 2021 13:48:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2736113B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Aug 2021 13:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC2736113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBdjK-0001fL-7i; Thu, 05 Aug 2021 13:48:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yangtiezhu@loongson.cn>) id 1mBdjI-0001fF-Uj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 13:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jjOidPbeRf5oG3FWIlWKEUmnnU1d3Zp4oG74E9lVON8=; b=brso2yGrKVuXPnYuQxXblGYWPA
 b4QFl0/VoZNkBCnxOCLQiy9DC/1K/iW8vx2l7HhZN7dE9c8J3mr391qbgEoO6iVGXa0UMjws7hMyN
 yTQfjZQz4NHspa0IAWGNGEVzWFLM3VBo36JSiaK+FmbGP0T3jwmdoGGwb44CmZq7+txU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jjOidPbeRf5oG3FWIlWKEUmnnU1d3Zp4oG74E9lVON8=; b=Re4TqNtB0Mz6EqLjsWYGD30Tfi
 ULP9Rjs7WkaTBNPfbWN68t7AzfA7aKOW+7LfD+jBQLamJqc4EMcXiV9Cm/ttF6uFBjC6kDL9mN0f6
 0T3rci3lAI1hhAWYyNrLSORak23lfkATAymnpBgduXuJLIEPlpBPAYhTYbM3Slx2ijYI=;
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.92.3)
 id 1mBdjA-00DMZ6-EP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 13:48:12 +0000
Received: from linux.localdomain (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL0Dw5wthzHIrAA--.32320S2; 
 Thu, 05 Aug 2021 21:30:25 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu,  5 Aug 2021 21:30:24 +0800
Message-Id: <1628170224-13239-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxL0Dw5wthzHIrAA--.32320S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryrAFW5XF4UKFyxJr1fWFg_yoW8ZFyrpw
 sYgry8GrZ3WF15KanYgrn8Kr47JryFga1UJr43Jw1UArWrGrn7WF95tFs5ZayUZFZxXFZ8
 uws0grW5Wr4avFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ry8MxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
 IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUsUUUUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Headers-End: 1mBdjA-00DMZ6-EP
Subject: [f2fs-dev] [PATCH] f2fs: Kconfig: clean up config options about
 compression
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In fs/f2fs/Kconfig, F2FS_FS_LZ4HC depends on F2FS_FS_LZ4 and F2FS_FS_LZ4
depends on F2FS_FS_COMPRESSION, so no need to make F2FS_FS_LZ4HC depends
on F2FS_FS_COMPRESSION explicitly, remove the redudant "depends on", do
the similar thing for F2FS_FS_LZORLE.

At the same time, it is better to move F2FS_FS_LZORLE next to F2FS_FS_LZO,
it looks like a little more clear when make menuconfig, the location of
"LZO-RLE compression support" is under "LZO compression support" instead
of "F2FS compression feature".

Without this patch:

F2FS compression feature
  LZO compression support
  LZ4 compression support
    LZ4HC compression support
  ZSTD compression support
  LZO-RLE compression support

With this patch:

F2FS compression feature
  LZO compression support
    LZO-RLE compression support
  LZ4 compression support
    LZ4HC compression support
  ZSTD compression support

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/f2fs/Kconfig | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 7669de7..2ac026f 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -105,6 +105,13 @@ config F2FS_FS_LZO
 	help
 	  Support LZO compress algorithm, if unsure, say Y.
 
+config F2FS_FS_LZORLE
+	bool "LZO-RLE compression support"
+	depends on F2FS_FS_LZO
+	default y
+	help
+	  Support LZO-RLE compress algorithm, if unsure, say Y.
+
 config F2FS_FS_LZ4
 	bool "LZ4 compression support"
 	depends on F2FS_FS_COMPRESSION
@@ -114,7 +121,6 @@ config F2FS_FS_LZ4
 
 config F2FS_FS_LZ4HC
 	bool "LZ4HC compression support"
-	depends on F2FS_FS_COMPRESSION
 	depends on F2FS_FS_LZ4
 	default y
 	help
@@ -127,11 +133,3 @@ config F2FS_FS_ZSTD
 	default y
 	help
 	  Support ZSTD compress algorithm, if unsure, say Y.
-
-config F2FS_FS_LZORLE
-	bool "LZO-RLE compression support"
-	depends on F2FS_FS_COMPRESSION
-	depends on F2FS_FS_LZO
-	default y
-	help
-	  Support LZO-RLE compress algorithm, if unsure, say Y.
-- 
2.1.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
