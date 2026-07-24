Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F7C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DQKYSuXow30MTCpwhOZDVS2X4EQIUup0XFaQ2h79AF0=; b=iUzycUMpO8Vgs/bc2RkoQJg9j0
	5HHOU/HBlysVlj5WwDnVZiSwmIso5lwdl26DyE0YKprPL7Ino66r+g7wu0xW9+Fwwfcq9+SBs552U
	Su/d7W+m6jk7Z37M112nC2fSeW3ia2ScRms8hsB+Xd751QZw1fmqXjGDr2Udak+rJvuU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI0I-0001e3-Qo;
	Fri, 24 Jul 2026 15:40:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wnI0H-0001do-GZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GoG776FOxAzFpdqlvSBLgqWaGQf+lsnQD4Zewx3Fwo0=; b=XXqw/G3g+h6i+nvxEYUK39fN4Q
 iCCAQ5QuYvWLMJC2dZw/vTnWVfo/vGwcZ503zp2ZkwpkRjnjr+2b2Di3aj9X28bsY1+2hUiYJvrlA
 CSaiIhwxLtPXH/YeFY57kPs19vNPyh/90z06AJlsjIGsw5DmaUT/05YtyhbwfnToCDAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GoG776FOxAzFpdqlvSBLgqWaGQf+lsnQD4Zewx3Fwo0=; b=g
 xwjdVI8VvTeNIJ8VqrVRA8poqetheXtYZIf8cbUK/eIfkQXfYWAcqSOD8Hp9qgFlCmmjzu0HYE08w
 vcMolCSlCqrSBG/24I59XPglxYYNHfs3nLzuYFAdv88sEJxnAhq6j99e0hVAUWwFAHox+18V26uNa
 HQN7bBbgNK6Q/mDw=;
Received: from mail-qt1-f180.google.com ([209.85.160.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnI0K-0004hB-5i for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:40:02 +0000
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-51c2a76536bso6554571cf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784907594; x=1785512394; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GoG776FOxAzFpdqlvSBLgqWaGQf+lsnQD4Zewx3Fwo0=;
 b=fDl4q7bCvH0DlPKWdt5jwFXkompeY8EGp7gAtr6RbOAEZBevncwj/QZEtL2YA6WbvR
 SYndYjEqJvrYXLWCy5TS/juyX9e65ZGojWFXR/qsLwoW16G3ZMcUK/Bllx0kELqE+JMz
 IBHO59Hv0jVQwtK2O30ar6RcfYsw/hJgy+QLHBNkyws1LjDWyidKjNAikxlZd4OxypAg
 x0N+MQduTjzQ0ffDxtO7jKlEkYEgNI1AF3xN5rdHbGxuRBZHcRjjsnTB9Xo66p2joryl
 tO2y1A76oetNVWbw2RiglWKYdSbGhm4PWZLsg7URQeNd3HOWoXHnai1eTQ8QAt4lRczE
 C6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907594; x=1785512394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GoG776FOxAzFpdqlvSBLgqWaGQf+lsnQD4Zewx3Fwo0=;
 b=buHFyekLOsgV3Ehgooq6Uv8jgMvshVturyyCX/OGxhuaQlk6T78lPJlSGJvNyjXA8l
 sgJiTjebRyRuvbBh1Mb7Z/D9yVP+Mvqihw2DEqM95mOvbdmlsbEOzs9JKcytymudwbOh
 IWM6C8QiisdBPxY/ehKPpIHlyZG4SxnSwEr+ZFhrxNDzBnouLpvK/57dnVTwyV/EAjSG
 pkFPozc2sD0QM39dBRZSZYRXn9/ZQX0u37Mhuac06ImfImU7vFgzIj8qUFZ5oW6o16SO
 YKajrjmH3o45wduc/w3wQsMGlOQLM98OK7DV/NdCjYDXnQJknr5XpftFkaHgWcONc2He
 1nzA==
X-Gm-Message-State: AOJu0YwhmjhcOnJ5KnF/Qy4Lu2B9bAjQzFWFPUvMiecWk04b+/98mTUV
 lPs+2O22lY6RCYVuwHiMySXA4HgrXfVon/2n3LuXy4Hq3B00G3GJllh7DAEFLA==
X-Gm-Gg: AR+sD12/GVnBx3B9Ugk3krl5JplT7fq4anyyxY0ZbL4vzLvKxYbTwREaxW5AAcfwwRV
 t9xZRCwVjkZkEbkwbZLzooA64d7WgGnzyz+vuFceSbYDRrXCp/l+Gd5uBVXkU+Qkna1KEeLe8eo
 4YWOEQsN4hQBzeHnhZFifyrr0laU1RcZQ4JP8EKr7+ldJ9kwdszmLTZggGmR/+QFUn1mP+5GZCQ
 hYrngYMwfv//eIlzk3+PsC5porkoEnxJRIcucL4YzjFtMltY66cvS9DcZyRbMz/ERbIUM1E3oqt
 o26unjNR+QBoRY5ifFGzY8wpDl77JYoI1euiXaZJgbQA0TgqMIIDm5ThpKR0Z+IDuZ0QCuOnrIL
 0ewgTr53nOATCE3xo3jmTlPPMlvt91+cS75GrEK29NuWblbcJzVs8ssIihAADb3t3GxBQcMrg1x
 bySYyKwnmq158D0b2BoLjSB6V30wtKBwQz0OGN7YhZlA69qFX+
X-Received: by 2002:a05:6830:6106:b0:7e9:ea18:d1e3 with SMTP id
 46e09a7af769-7ee43fd863bmr4337622a34.29.1784898011642; 
 Fri, 24 Jul 2026 06:00:11 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee2a0ad03asm6069433a34.22.2026.07.24.06.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:11 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 24 Jul 2026 20:59:57 +0800
Message-ID: <20260724125958.3929130-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wnI0K-0004hB-5i
Subject: [f2fs-dev] [RFC PATCH v3 0/2] f2fs-tools: adapt to inline extent
 format
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

This is the f2fs-tools companion series for the kernel patchset
"f2fs: introduce inline extent mapping for inode data blocks" (v3).

Changes since v2:
- The kernel inline extent feature has been redesigned. The inline
  extent area is now placed after struct f2fs_inode->i_extra_end,
  inside the i_extra_isize region, instead of repurposing the direct
  block address area (i_addr[]) with dual magic numbers.
- As a consequence, f2fs-tools no longer needs to understand or convert
  the inline extent on-disk format. The bulk of v2 (the 787-line
  fsck/iextent.c core with lookup/insert/merge/split/convert logic, the
  datablock_addr()/set_data_blkaddr() rework, and the build plumbing)
  is dropped entirely.
- Dropped [RFC PATCH v2 2/3] "build: add inline extent build support":
  no new source files are added, so no build changes are needed.
- Dropped [RFC PATCH v2 3/3] "f2fs_io: add support to clear/set extent
  flags": the per-file ioctl flag no longer exists in the kernel side.

v2: https://lore.kernel.org/all/20260529085745.2664678-1-yangyongpeng.storage@gmail.com/

What remains is a small adaptation to the new on-disk inode layout:

Patch 1: Adapt to the inode layout change -- split i_compr_blocks into
         __le32 i_compr_blocks + __le32 i_inline_ext_capacity, add the
         struct f2fs_iext_header definition, and keep the inline extent
         consistent with the largest extent cache by invalidating it
         whenever i_ext is dropped or truncated in fsck.
Patch 2: dump.f2fs -- print the inline extent capacity and all extent
         entries for inodes that reserve an inline extent area.

Yongpeng Yang (2):
  fsck.f2fs: adapt to inline extent inode layout
  dump.f2fs: dump inline extent mapping information

 fsck/fsck.c       |  9 ++++++---
 fsck/inject.c     |  6 +++---
 fsck/mount.c      | 20 +++++++++++++++++++-
 fsck/segment.c    |  2 +-
 include/f2fs_fs.h | 22 +++++++++++++++++++++-
 5 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
