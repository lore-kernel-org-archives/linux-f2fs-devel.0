Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0CEC61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21nc8Ao/41qZRJ0s/PM5eROF4oXbTzntDpJMmG4QVTI=; b=L/DWf9rcFsoT3u0wB6SNRok/Ba
	mnzXJQ7eHEKSdz+Oq0PNpB3TL7Wpi+B/EmEb/gBCyM8HlToL7BCRJehippgDCDoDGbq/EiwRXW8+V
	91IekZyTO7tQRpgMgp++cloY2WBz9ejlY8/f9/CLU/f6CPvK5Z2XbjbXx8b3SRtvW6Yk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzqtE-0001lT-NA;
	Fri, 28 Aug 2026 07:20:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jeuk20.kim@gmail.com>) id 1wzqtD-0001lN-5t
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GzEDMkX4yTC4NY1QHzlw8SSeuXFcMhPqxibPy+lQxOY=; b=VqWXYMx1iciJQTSVmVm4EwuEVp
 kENJ5YyDJdsUhigLEuzbCQY2XC8235tuwz87E/WNoSkzQBCVcmUnaL0lDMTYFvnnBLbctOTAJ9zlT
 AojR/RweZ9Wr6NV8zhyxf24tIAICHFLpsVL0Iv6DVgozLpJQvs/m/wCOCTePJ/oPghYA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GzEDMkX4yTC4NY1QHzlw8SSeuXFcMhPqxibPy+lQxOY=; b=e0elxDkrRGVkoNQcSSZX8QB3qn
 gdxiTHxW3HZiKIIrqAOFVRXn/86/R7V4MMnVZGXZ+tW3MqSQSDIvqVEzZrEJc/TlwpSdUgHiHz951
 rNdsRAbso4eos67tRwhKTvez8XLTRMQOkpiWQF29afmRTkEt4Y87Kb6J31ixCYGcc7lM=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzqtC-00030v-JK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:39 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so640416a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787901633; x=1788506433; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GzEDMkX4yTC4NY1QHzlw8SSeuXFcMhPqxibPy+lQxOY=;
 b=IuS51SzBGmGtVMCYxdnOQ9ZRv+vO9dqo7h1libS0DBZi2J+eIzlYQU4P933QUw10Se
 KBiRLqGqqNag2NvhDxA1lx5G8jevJTVuEWYjDxGcVQeKtYAhLlwNeGnuD2Hp5tGwqHPZ
 pfGOZNdfKR8P8P5oHgOvRnDvrIwfaeobl7FBCW2wfcUOMKw7gV76Zx/8KvQksdBF7PW8
 sBxXuPONcimkiq4vUCKee1IqeH4Y7cSXUYO4Y5zJgGcJEH6fhYIAxHgPQLFMoMVVWAzy
 ZeixkvJznOgg+sQ2hRnJRTH9+zjR/Ehp84J/xj74flC3HGfBk7h/c+38utmX7aAeHMEG
 lKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901633; x=1788506433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GzEDMkX4yTC4NY1QHzlw8SSeuXFcMhPqxibPy+lQxOY=;
 b=fPBPLUE3LEHwe08fheQUbN7TUHIJSc9JXqko3KfqFWyTqQJ1Q2kH/Zgn8EpIVXtf37
 QEmsiLJxci/qh/xMG+ZfJG836/P8chTBsWffDxwkzYgpaKVXOgDvbfe3GzCKx0j888WY
 qhQsvC5lyUqZC+GpYL3QfFT04Sj+1rPcxOLbd0i9YKttoYFwpMe21ClSPbDua1+EDFwH
 PD32dyiWfNDQBP46rVaurg+bHr/ZlV2AGQCJ/BWSyTZvfFe571WNRsJs9jhdRYpisdYh
 sal3BxH60DPnO5up12jeiyZDhzLFLUjihMJ6WcmF6sOP+ldiWvGv1/V6O7jxwkzlM8Yk
 4I+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKRYV9hQzSQUZbv+6Pyl4SYO98Rcny8DxD7+C1qMWrvg3R1J8J9MFtMHeprA2SVecax1BeqQEKmKfd7Bm1GnHP@lists.sourceforge.net
X-Gm-Message-State: AFuF++mF6JyNXdydY7PzC2rAuUe32cbIeOZ9l6oOUOGBZuhdXWbyOwC8
 wlu+wsBy4TgIfUAILbo0UAsJZIO1uZNK7yra23Bu6EuG8EGJBboID+NgeB6JlQ==
X-Gm-Gg: AR+sD13YYLY3YkHE+O0qMi7jfzxuB9229uGoe3h8UhE9QgKYT0jy3D4WUJ8gjeSc+BL
 gP6tj1p2eiFijyhLiKLAgRbrxhQdx4JW5O7jKHPrWohDvCeLySntMMZ5LFvWBPpAEf0UgW8eHGD
 vvc179G1odNM4xQiKq4/RYgFwPcQNFshWNn8MkphKff16AswW0eX8UicGoCLgLesNo2GoKbZZWp
 /3Ixcb9nFEHCsXwfkSNNVgmACev9YIyoqtDuPNn1kw2sDNYhXEItupwGOdPHsQTViUJBb/JvW7q
 TvijUVvaYSMNq/h7BSQvArsgiV10g98ADzR9tUHAyA9YZ6zFekdJjiLSh11P0QlnDts13PHizWf
 aeZRatlUdw4XeJvEKXR1YdIENtSE7qekjgEWHa20J9mxCehILhs8gvNYc58y7kJroe//CGfTVDG
 ZLu4AZjrt0Mt8CXlKidPOtcmkQzKTHwK62Xhj8UnzOd9A2Rz5UavM6geH0z8B/VC2aL0g=
X-Received: by 2002:a17:90b:17c3:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-396d0ea9ce7mr7311266a91.2.1787901632866; 
 Fri, 28 Aug 2026 00:20:32 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm6123731a91.4.2026.08.28.00.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:20:32 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 28 Aug 2026 16:20:15 +0900
Message-ID: <20260828072017.44569-2-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828072017.44569-1-jeuk20.kim@samsung.com>
References: <20260828072017.44569-1-jeuk20.kim@samsung.com>
MIME-Version: 1.0
X-Headers-End: 1wzqtC-00030v-JK
Subject: [f2fs-dev] [PATCH 1/3] f2fs: set FI_UPDATE_WRITE for in-place
 direct writes to pinned files
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
Cc: yunjae00.jo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Yohan Joung <jyh429@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_dio_write_iter() does not set FI_UPDATE_WRITE when do_opu is true,
assuming that the write landed on a newly allocated block. That assumption
does not hold for pinned files. They are updated in place even in LFS mode.

Without FI_UPDATE_WRITE and with no appended data, fdatasync() can return
without issuing a device cache flush, leaving an in-place direct overwrite
in a volatile write cache.

Make do_opu false for pinned files so that FI_UPDATE_WRITE is set and the
flush takes place.

This can occur on zoned devices, which force LFS mode but allow direct I/O
to pinned files, and on conventional devices when a file is pinned before
the filesystem is remounted with mode=lfs.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 089759366cdc..51518caee460 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5166,7 +5166,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct inode *inode = file_inode(file);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	const bool do_opu = f2fs_lfs_mode(sbi);
+	const bool do_opu = f2fs_lfs_mode(sbi) && !f2fs_is_pinned_file(inode);
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
 	unsigned int dio_flags;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
