Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F7C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NutKRoM3kl3w8JojUfK3C2l1hQAk52ERnsGtCakmsBM=; b=AQhXlTNVk4/tt7Zfxc+TDtKOCa
	travyEu1OMR0AXjdMZf0HO+0wGmUjLeNsOnUD+MZf8eM/i+t7i7WiMKiNGFLjRxGoVPoLr55nmP1I
	tNxjyTn8QJhDBBloj2l6XZH7oJUj2kmSYdHHDU4YBlKTZyb7z4Zb9gCvF0Cg3i8uCj1M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1xui-0003Bd-Oi;
	Thu, 03 Sep 2026 03:14:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <firefly0158@163.com>) id 1x1xug-0003BU-GR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 03:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HVaqmg8FV1YZ0q2hhsoEALM5vnRSY6kXKAfukQJc6dk=; b=CJ1u/Jlv+vvg6gjRsYVUCLP7C8
 H259xtsdXDHkEnkzB8QoDx6Rqb8Bgen2Kwljlbk9c1rhSh8Xh49a2tWEFiej1U4fPXgyMzBOLSPHv
 HKChsDmsOzDBd6Prox2HgP0+vNJdOocL31Y0mI1tHHiCPON4JiN/WmyDIyCa9Qmt2FkQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Cc
 :To:From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HVaqmg8FV1YZ0q2hhsoEALM5vnRSY6kXKAfukQJc6dk=; b=i
 lOkJYEsKrgopO8t9e2zvonffnqItYP+/aRGuEtRoPr/j0ZAai0GfRB5PvfP8S7GBYO6RrF7sNp5/i
 arB8B9C6Th3b6lK1per4wIszIls1tj7JzbQK8YDIPShKszfmSgwpfQ0PomiTUqpONIAF89GgQB5RG
 I6eLrnKflymO2kOE=;
Received: from m16.mail.163.com ([117.135.210.2])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1xub-0002mt-5y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 03:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=HVaqmg8FV1YZ0q2hhsoEALM5vnRSY6kXKAfukQJc6dk=; b=m
 c1CDzvjINjEcW2elr9Tp7veyQoq7G4J/7Klzg1/ANOcz385GzSUHR51FbBW49IwM
 vUYquoZ5cTGtMl6FJ3giKQUQliYC6igTZ5j6yiF9LJTW846iHWIOtj6y89blipE8
 mRjMeaH65N3vieIi6CK1nm9IZTTkphh1WVwwdhJ5ow=
Date: Thu, 3 Sep 2026 11:14:28 +0800 (CST)
From: CJ <firefly0158@163.com>
To: jaegeuk@kernel.org, chao@kernel.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2TCvibukot7iacYOkdnk8aj+g+UcCwufkj24Bfc+8GgRv84DoEfW1FPnbL6uekLwG0vT6TaBlX0txmU4J4jMFR5/diWdSgtB0CSgq1zQ==
MIME-Version: 1.0
Message-ID: <d1f8ae2.2f3a.1a06542c0ac.Coremail.firefly0158@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: kygvCgDXPzcV5phq5FI+AA--.6945W
X-CM-SenderInfo: piluvw1o1qikqy6rljoofrz/xtbC+hV-MWqY5hV0+QAA3t
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1x1xub-0002mt-5y
Subject: [f2fs-dev] [BUG] f2fs: possible KASAN use-after-free in f2fs_iget
 on v7.2-rc3
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
Cc: syzbot+0b1e85354f790743db08@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Hi,

I am reporting a possible recurrence of a KASAN use-after-free triggered
by a syzkaller reproducer on Linux 7.2-rc3. The issue is reproducible
with HEAD commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa.

The reproducer mounts a crafted F2FS filesystem image and invokes
open_by_handle_at() with a malformed file handle. This reaches
f2fs_nfs_get_inode() and f2fs_iget(), where the inode and its extent
cache are initialized and validated.

The archived target crash report shows a use-after-free read in
sanity_check_inode(), called from do_read_inode() and f2fs_iget(). The
affected object belongs to the f2fs_extent_tree cache. It was allocated
by f2fs_init_extent_tree() and freed by f2fs_destroy_extent_tree()
during inode eviction.

This looks like an extent-tree lifetime issue in an f2fs_iget() error
path. A stale extent_tree pointer may remain accessible after a failed
inode lookup causes the inode and its extent tree to be evicted.

This appears related to the following previously reported issue, which
was originally observed on Linux 5.15:

https://syzkaller.appspot.com/bug?extid=0b1e85354f790743db08

Reproducer:

syz reproducer: https://pastebin.com/raw/LGCbYiqL

console output: https://pastebin.com/raw/FzSecFbT
kernel config: https://pastebin.com/raw/PZsF562V

Kernel:

HEAD commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full)
tested tag: v7.2-rc3

Let me know if you need more details or testing.

Best regards
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
