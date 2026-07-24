Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3A6C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7GiMnP3EcW8+6nNxdmzbr6BUlf3hiq4RRvudY6e4ck=; b=eMAW33u1wtpMGqYCfNEl645c0V
	/nnVI4vETyzpGh5TcOvP5UBd1B5hnce4zTetSupu0P5sHHg++0JNAmsp8eva2yGNqmrYAIJvlkt1N
	tUVSEzp0+sPxw5jJaYDDNLN31fAJEGxDaDIjQeoJ657HdyzrGMtIWu5iYKVLHy0Cm9vw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHyO-0006Wp-0u;
	Fri, 24 Jul 2026 15:38:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnHyN-0006WR-0z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PjNwMz/Z5UG0ZoN+cxVL+762ajJBzWuLwkqAg/i2iNo=; b=X7LtxCAN8tFh3RQH9JoaYgS47I
 GA2xT7byqYVyZkdmJboQhEx926rnw60IfsudA5YyjInqAAMIVORd1TMUzCASVkRvDHlneVjWpdaw2
 nuiQ7udp5XD0nca70g4+95k6f5GFqIbTelRWtFGEguc/w3Xn/BO5DeA5sDsr5DJbOQ6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PjNwMz/Z5UG0ZoN+cxVL+762ajJBzWuLwkqAg/i2iNo=; b=mXpNF4hXte9737Wo0/+QVkiCCS
 wsXihH+1ti4GugqQ11x6pSZQ07jaauviAAXXfLHlEpNYf31NsxhRY7ZeajMIrQD4Cb7GSVZTBM08j
 B9AiGq3zuNO+9L7CC1KeZfPmvqVOmhWiLpmrYbije+PTddXKFAlo7fx9rt9HFCnwqB5c=;
Received: from mail-vk1-f177.google.com ([209.85.221.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHyH-0004bj-2F for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:37:53 +0000
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5c27e38ee18so275124e0c.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784907467; x=1785512267; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PjNwMz/Z5UG0ZoN+cxVL+762ajJBzWuLwkqAg/i2iNo=;
 b=EiTbxVop6z9DO9iuZxt2wzmZrJkAaYOwgV9wp4YW7tjU2MzHykQHbeZkCSNWZxHGFY
 V6p9xfLrVXV2XHeIQZLnl5vhJ8SsdaJIhpBV8j5hvJ341bvzTHWIMjgBs/Xv0PMDmnWz
 zpfUnPxOOc8uGly4dm8kFLCcZQ5MVmHmM/6lV9IaCLWMbZeo9lk1J5Ne35bQ2yHy9v/Z
 fYNdb1s0HCw3CYqEwamuCFGjt5tKybiZdFA/CjC9vQga6SahTEXzSxEQksT9FaDtfC1h
 /6Xse/7GWt6D3GM6z0rUhxvgajel5Kbk7sFAtDtPsO2e5ObQU8JgSu7CoxM4uzN/4sfZ
 wP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907467; x=1785512267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PjNwMz/Z5UG0ZoN+cxVL+762ajJBzWuLwkqAg/i2iNo=;
 b=deAnVY/OjfTWYcDxkYDOYe5B3N70PYEWLCViSU1jxf1JwqkbvzYBGize00O2ywTaYl
 MXMyKGkJPEesLTZKh2KoUr55X2YxlMbE+zBG/F09wYWC4vEUdHPsr1w7tPen8omLsEIC
 21+eSfFFZibfRgiV6Bo4vj6b5sFp1rwk5UmL5o9nWg7+pYRpUmiz2sZROmNgzeQhDD3z
 tLwjQcmf4+eSYKTFTdKTzvIeXIpbhgoJHeDsFFBr99/QU40U55n1mWG+g/Ndr6HJTnC3
 8DWDMRLJrHGPwrfMovIE2l9zHz83pva1xJ9QZfn/PhbbHvGwHn2WTQ7tPlUsVzazAwL1
 YVIw==
X-Gm-Message-State: AOJu0YwUn0fkJxd7UFNP2pLgHzflCQ81emqfPebGXl/XtzNEQYWkHQ5k
 F7XrnEl10Kbor6ejpOrocRhU7IIVfxKRAlW7sGg4GqnG5FBoOsJZY5vcN7lhmg==
X-Gm-Gg: AR+sD12B1snZ3Sice/lZe+w/fIKmtKEjK1CuK7nc6urMlZDUZfdVVe2Xn1dayaLxG8T
 WlxCYwngaTc0rTApPrLbBjgE//f+UzTjW3CLSlC+7sVHZRvRxCknmnuTzAGEOBjpg9nKzai/E7c
 UI+0Qlfl3Qb2k1Ugv5ve//4/PM73Pnw/Z+i1sEj/1m3V7UkPpE1G3V6VPeTt10x0bebJRRhP61B
 FItS3cN4lKZ7AkHFLEcQ4S8OarGs+bfITaFHPxbIF9KXcyBdkquVZrK27cTu7VRY62dcJax4TqE
 /i3lG7Y47JYTLGdo/DlWwngKYOR+zwESqKVs8YZsB5mF9v4acshZyCFQ+Ab/dpM4tOKxCj8U4aC
 QmYEPJqMiR/d+rcRiiuIstzKme3V/n3Q25ZXfTg4p/P7Uhz4W9dO0ClMfLcYXsP1R42zRbjFZa6
 qxpm8+X4eNHMxw7rAQT47eCsjhw5lftcOtXHCyy/MFhOqMOWVFtAyQDD2igdw=
X-Received: by 2002:a05:6830:661c:b0:7e9:e313:4fdb with SMTP id
 46e09a7af769-7ee43e3f812mr4671044a34.2.1784898022098; 
 Fri, 24 Jul 2026 06:00:22 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a0ad03asm6069433a34.22.2026.07.24.06.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:21 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:59:59 +0800
Message-ID: <20260724125958.3929130-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724125958.3929130-2-yangyongpeng.storage@gmail.com>
References: <20260724125958.3929130-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wnHyH-0004bj-2F
Subject: [f2fs-dev] [RFC PATCH v3 2/2] dump.f2fs: dump inline extent mapping
 information
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

When extra attributes are enabled and an inode reserves an inline
extent area (i_inline_ext_capacity > 0), print the capacity, the valid
extent count, and the content of every extent entry (fofs, blkaddr,
len) in print_inode_info().

The inline extent area lives right after struct f2fs_inode->i_extra_end,
so it can be read directly without any format-specific decoding.

Example output:

  i_inline_ext_capacity         [0x     100 : 256]
  inline_ext (cnt/cap)          [3 / 256]
    inline_ext[0]: fofs:3ac blkaddr:12f400 len:64
    inline_ext[1]: fofs:410 blkaddr:12f480 len:20
    inline_ext[2]: fofs:500 blkaddr:130000 len:c

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fsck/mount.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 8c14c97..1c0429f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -349,6 +349,23 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 			DISP_u8(inode, i_log_cluster_size);
 			DISP_u16(inode, i_compress_flag);
 		}
+		if (le32_to_cpu(inode->i_inline_ext_capacity) > 0) {
+			struct f2fs_iext_header *eh =
+				(struct f2fs_iext_header *)inode->i_extra_end;
+			u32 cnt = le32_to_cpu(eh->cnt);
+			u32 cap = le32_to_cpu(inode->i_inline_ext_capacity);
+			u32 j;
+
+			DISP_u32(inode, i_inline_ext_capacity);
+			printf("%-30s\t\t[%u / %u]\n",
+				"inline_ext (cnt/cap)", cnt, cap);
+			for (j = 0; j < cnt && j < cap; j++) {
+				printf("  inline_ext[%u]: fofs:%x blkaddr:%x len:%x\n",
+					j, le32_to_cpu(eh->exts[j].fofs),
+					le32_to_cpu(eh->exts[j].blk_addr),
+					le32_to_cpu(eh->exts[j].len));
+			}
+		}
 	}
 
 	addrs = ADDRS_PER_INODE(inode);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
