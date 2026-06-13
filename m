Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6CACD8CA8
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Jun 2026 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kHANWBIHC5VUTp+ZqqujsKXf7lBZy2u2d/bzWjc1lCg=; b=AWiVvEqk/jFVRDtze9Q829Jbkr
	JIgu/Tv+tdrBguS/uVa6gogJYHPup5LT2QXpS31Z2o7Q3om4jTSycu5SJBB4244lYa0BVKN2D2SPE
	F08muRi09z1pVo5jwRJKUadCEvmg10MkDLJ6JSmvyAuFFFe+GJO3/oAx5vyOpW+L4VkI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wYMBJ-0004Ka-2a;
	Sat, 13 Jun 2026 11:05:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rollkingzzc@gmail.com>) id 1wYMBH-0004KM-QL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jun 2026 11:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pBdRLyUsJiYShnn2wOSBi8GYR+LxVfalSBx2Fe/OETI=; b=L1uWLlebvIvoXWjpVNO4xoEyYA
 +9Zzp//iLnQ8k96HYBylJc7bdjhsb8gKxJK6UtaLb3EIPYYr43nQDKW3RUIcGaCFK7TmC4CcN5uVq
 9+7N+VhqBqhTFQMnKVgRZcRxlyCWvarlNAgMDZMK01JnUs5jVdpdLAKmDLJgO5APupNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pBdRLyUsJiYShnn2wOSBi8GYR+LxVfalSBx2Fe/OETI=; b=B
 zI2MKqQNc5SheS4In6A99cYw4dM0nxR0pcZlBUP7D4j7AZK+siUCzOrCXG1HjADXGEdE3Nd2wuaW0
 t1kYIlADMu6DHGPlmDB2hpByZAdxsMFAk7JPBWt27RVfzYmInxnU7JpNgtfLdbmVK5lzSa2Vhgpii
 tgOpV3Wcz1KDqiVc=;
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wYMBG-0007Jk-Ot for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jun 2026 11:05:40 +0000
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-842358aaf36so768121b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 13 Jun 2026 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781348733; x=1781953533; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pBdRLyUsJiYShnn2wOSBi8GYR+LxVfalSBx2Fe/OETI=;
 b=Bo2VWQJzDN1IOiEhaNMKKWMHxVPr+DPtiIVSVZjjxIqotbv5bIkiKmuLZYDMf/y9/Y
 Ppnx8FaECIPbidPNQv0YO7B2gk0iN090KmWOOd41DRbbAK3ipKFeqNcoR7wDYD16sMFt
 L7SOfxa4ROQ9u8JvzHQoBhttbEYNLfr5buuHrkSnhYgMnrqzTd+i9Ls0uolFiPlJ5QGJ
 MayauLBys2ReiP2fwIHpTSanJaFksgq3txaBE2LBuu4KYtd5hJa2U43hruQMAcDYd7g1
 d8WLvLRpLpR+/PSuLKPX2xQolbul6pTWVcM16xdzHdr8Fo+JyPaMAMOTBP5WpvJ1FylT
 XLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781348733; x=1781953533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBdRLyUsJiYShnn2wOSBi8GYR+LxVfalSBx2Fe/OETI=;
 b=ZUd+3CH6E56ChKsO6sUODQpQ4tcTAIrBJojQsHloS2u1e+UgJ2NhFPbsu06nx3py1z
 LUy624E/xdmiyqwdyKJ0oQnaw9gi2dG0T31QndzdAEZB/7tY+HONWulEgxMz3zqScwZW
 6/nuBoYJZABSTpypJVu8joa1CLlIFrJBQt65BAbeSKGoBstgU5Tc8GYPSbPm9OA0b6tO
 3BJfA/Pp8UumnNNnwMEnURBEgpATcwVd0u4QGOKfyHruzYwYlzumrh2YzDKyrpuKBlDX
 R0I2eEz2SAjsDWbsw2wBPFMIeh2eFPeMDWt8Tc+4/An9EBWPouxb83DpRmm4N1wAuEwW
 6Ogg==
X-Gm-Message-State: AOJu0Yw5K+En2YCHY0ntGR3zZ+6l4vd/Z0wtIOb9y4ES5Bw1baoI9bCL
 yhAGM5KanzuOC2L1yQr7qq/8pgxWTvUS61cNAnA98e+KaDi9MPN4nOmA
X-Gm-Gg: Acq92OFjHK6RRy6zRAeoOIJ0Y0iIrnkAQBZFzjZmmZ+Tp79tZijuuDWXPfMSLQnUSN7
 FrIMC8rmZzRTOMvrUrw/gWjl1KjU16clAkjosCte+nYa1nyihha3s1u4wguqApxT/vsepeW9642
 1U4FYqNMRzxY2+S2iyteIAFg4fqKlq15Msd17ArDHsnMcfQM5opYfhvFPn38SIsII8t6Lb3faX1
 tiZwIGY6EL9AwhnP2gstlcSGXSP44S8eZAuHFxqIwUNZbTrlx3s/rBBgQ7GHgxeOr+UNiSeOKhV
 snibPaRGe5K6q/nU5EaDPtF4WX78bCm68EuQzQmlDOFJjyTJp/u9s/L8Kalq3Y6mgcjSccgVyIi
 wifyDEAKXIs6evKjmojFFlWGV93ibwF+6ZIaJkejMs8NcdO/ZEI3wlDcopBrbH8R9qGWlQDpI1d
 1Pi70lyCV2paJ1CmiYbsJR
X-Received: by 2002:a05:6a00:984:b0:842:5b66:3c7f with SMTP id
 d2e1a72fcca58-844e1590761mr3744376b3a.0.1781348733408; 
 Sat, 13 Jun 2026 04:05:33 -0700 (PDT)
Received: from localhost ([111.228.63.84]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afd50e6sm4721723b3a.30.2026.06.13.04.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 04:05:32 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sat, 13 Jun 2026 19:05:26 +0800
Message-Id: <20260613110526.1347194-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1wYMBG-0007Jk-Ot
Subject: [f2fs-dev] [PATCH v2] f2fs: validate ACL entry sizes in
 f2fs_acl_from_disk()
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
Cc: 2045gemini@gmail.com, zerocling0077@gmail.com, linux-kernel@vger.kernel.org,
 Zhang Cen <rollkingzzc@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_acl_count() only validates the aggregate ACL xattr length. A
malformed ACL can still place ACL_USER or ACL_GROUP in a slot that only
contains struct f2fs_acl_entry_short bytes, and f2fs_acl_from_disk()
then reads entry->e_id before verifying that a full entry fits.

Require a short entry before reading e_tag and e_perm, and require a
full entry before reading e_id for ACL_USER and ACL_GROUP. Return
-EFSCORRUPTED for malformed on-disk ACL blobs so corrupted ACL xattrs
are reported as filesystem corruption instead of generic invalid
arguments.

Validation reproduced this kernel report:
KASAN slab-out-of-bounds in __f2fs_get_acl+0x6fb/0x7e0
RIP: 0033:0x7f4b835ea7aa
The buggy address belongs to the object at ffff888114589960 which belongs
to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of allocated 8-byte
region [ffff888114589960, ffff888114589968)
Read of size 4
Call trace:
  dump_stack_lvl+0x66/0xa0 (?:?)
  print_report+0xce/0x630 (?:?)
  __f2fs_get_acl+0x6fb/0x7e0 (fs/f2fs/acl.c:169)
  srso_alias_return_thunk+0x5/0xfbef5 (?:?)
  __virt_addr_valid+0x224/0x430 (?:?)
  kasan_report+0xe0/0x110 (?:?)
  __f2fs_get_acl+0x5/0x7e0 (fs/f2fs/acl.c:169)
  __get_acl+0x281/0x380 (?:?)
  vfs_get_acl+0x10b/0x190 (?:?)
  do_get_acl+0x2a/0x410 (?:?)
  do_get_acl+0x9/0x410 (?:?)
  do_getxattr+0xe8/0x260 (?:?)
  filename_getxattr+0xd1/0x140 (?:?)
  do_getname+0x2d/0x2d0 (?:?)
  path_getxattrat+0x16c/0x200 (?:?)
  lock_release+0xc8/0x290 (?:?)
  cgroup_update_frozen+0x9d/0x320 (?:?)
  lockdep_hardirqs_on_prepare+0xea/0x1a0 (?:?)
  trace_hardirqs_on+0x1a/0x170 (?:?)
  _raw_spin_unlock_irq+0x28/0x50 (?:?)
  do_syscall_64+0x115/0x6a0 (arch/x86/entry/syscall_64.c:87)
  entry_SYSCALL_64_after_hwframe+0x77/0x7f (?:?)

Fixes: af48b85b8cd3 ("f2fs: add xattr and acl functionalities")

Assisted-by: Codex:gpt-5.5
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
Changes in v2:
- Wrap the new ACL entry-size checks in unlikely().
- Return -EFSCORRUPTED for malformed on-disk ACL blobs.

 fs/f2fs/acl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index fa8d81a30fb91..e62ce979be0b7 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -53,14 +53,14 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 	const char *end = value + size;
 
 	if (size < sizeof(struct f2fs_acl_header))
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EFSCORRUPTED);
 
 	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION))
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EFSCORRUPTED);
 
 	count = f2fs_acl_count(size);
 	if (count < 0)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-EFSCORRUPTED);
 	if (count == 0)
 		return NULL;
 
@@ -70,7 +70,8 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 
 	for (i = 0; i < count; i++) {
 
-		if ((char *)entry > end)
+		if (unlikely((char *)entry +
+			     sizeof(struct f2fs_acl_entry_short) > end))
 			goto fail;
 
 		acl->a_entries[i].e_tag  = le16_to_cpu(entry->e_tag);
@@ -86,6 +87,9 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 			break;
 
 		case ACL_USER:
+			if (unlikely((char *)entry +
+				     sizeof(struct f2fs_acl_entry) > end))
+				goto fail;
 			acl->a_entries[i].e_uid =
 				make_kuid(&init_user_ns,
 						le32_to_cpu(entry->e_id));
@@ -93,6 +97,9 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 					sizeof(struct f2fs_acl_entry));
 			break;
 		case ACL_GROUP:
+			if (unlikely((char *)entry +
+				     sizeof(struct f2fs_acl_entry) > end))
+				goto fail;
 			acl->a_entries[i].e_gid =
 				make_kgid(&init_user_ns,
 						le32_to_cpu(entry->e_id));
@@ -108,7 +115,7 @@ static struct posix_acl *f2fs_acl_from_disk(const char *value, size_t size)
 	return acl;
 fail:
 	posix_acl_release(acl);
-	return ERR_PTR(-EINVAL);
+	return ERR_PTR(-EFSCORRUPTED);
 }
 
 static void *f2fs_acl_to_disk(struct f2fs_sb_info *sbi,
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
