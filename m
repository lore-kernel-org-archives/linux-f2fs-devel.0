Return-Path: <SRS0=LeJc=US=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB44C31E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2019 01:28:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C5820B1F;
	Wed, 19 Jun 2019 01:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MYARlPfm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aBT0WCsQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTDOJpyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C5820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdPP8-0000fx-OG; Wed, 19 Jun 2019 01:28:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kassey1216@gmail.com>) id 1hdPP7-0000fi-IR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 01:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=96RvJEfG+k8hrSiE8jkURjf6ZeK+2iz7GDHsoqd+9MM=; b=MYARlPfmNUFNBVBzcfH9XDJG+D
 u7LuowyS0CKI3dwqB1WPukW7Gk4HROk5AvKKi2fNl8cPnm7F/lLBf/MtJC+4n3eqGMhoZ50EiXAYW
 /BrHfqBnWmQoZe5hiISkPAIMmt/PW/Zy4z2/fEUjkbK+5h+pe6H7rImvtetzRzOnNpW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=96RvJEfG+k8hrSiE8jkURjf6ZeK+2iz7GDHsoqd+9MM=; b=a
 BT0WCsQizPRhavt0+K7vZIXHrEQ2auwO5DGVeERaj44ZKzA1/1yxsnmkwb9/WDq3jVyKoiXKIr5Xn
 Tws8Ph6kbiYj9D0E8e/xv95gWnFBB2hpkM6BlaMdSufOX845VayMaATmlp8qWGWd0BH3VyIIEMvu6
 Vk9OhU7XHqy69gSs=;
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hdPP3-004E7E-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 01:28:49 +0000
Received: by mail-ot1-f48.google.com with SMTP id i8so17541483oth.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Jun 2019 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=96RvJEfG+k8hrSiE8jkURjf6ZeK+2iz7GDHsoqd+9MM=;
 b=OTDOJpyQ5KxKnhjOtSdRd3Ipg2OczCiCfCzpeHdxaQbtC50/mRsAkeb1nYm/CLxxxx
 BJTWqZu0shCRlaIPGeVxdL2GFPkuOJG9aI5TZbpua2SPwLT+X37J8yLka9HLGDZrH21d
 DLzov62/vOahZyJy2Qg/ctrE0uABB1uof353uKpw/NEWdenH03LHz3lqr81+ao+Y2Whn
 vI3GPRQQc9ZUBp919TNXQCg3mJnOLUg67td+QVJvsFOOdHigQmXgn1a+exQ7IYKc8mrV
 xwSsHzfTNIqSncMRGKSFQ2p90Fq9InMG7RiSXjdpgicvJa9ULnCM2pRUAf8Y2ypwqaQ3
 CDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=96RvJEfG+k8hrSiE8jkURjf6ZeK+2iz7GDHsoqd+9MM=;
 b=dBBn50Pq3IMKJo0mtYm1QGmawqMuSyI3/VqOiq3a2TS+PsfZU7fq0r/gZRUDSD7tDi
 y2PA8Zx4neAKfGi72wKaaAnkm1WUXenK6BZRQkELFvf0ovNWtG99NySwYFrF4G7bHt6s
 ph45l41MG+YNFKm/41l8D5GluWLfkoDZbKDPY8EMv0KQm/6tLS3HvMfUzVTKv3kM8rnd
 kBPlW+AqCvyQUyYL0sYC8K1gsUyyXBdDBLBpWbYx5zbxwB/RLJPLxxkx/fvATkV+N5a6
 mKcJqjZvkEV6bdBSRtmRfQy7oxaoak+7yegQ9r/RL7Q6/EZDkgBpP87/VVxZco8F4kCw
 nKnw==
X-Gm-Message-State: APjAAAVW7tBV+KBr+SJ6f6O81qXXygybI1M8Tzp/Szv6Fb760MDYk+J2
 8j76bkVvCQE60BATHDIUggCqq3xhsl3T/ZZSCrOfF0X4
X-Google-Smtp-Source: APXvYqwJFemHOZ6951TYnRmlzCgGcGJAhqynQ2dpOcgqEZcG4siRCIlLCOKryaaFM5IBQfb6TyUf3aCIniui1kpJEnM=
X-Received: by 2002:a9d:66c8:: with SMTP id t8mr9895921otm.94.1560907719530;
 Tue, 18 Jun 2019 18:28:39 -0700 (PDT)
MIME-Version: 1.0
From: Kassey <kassey1216@gmail.com>
Date: Wed, 19 Jun 2019 09:28:28 +0800
Message-ID: <CAKwPUoyvn6mjEw=DfPTpLBZy-NQvtd8fpjfpwRRGMvqshB5gxw@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, kassey@126.com
X-Headers-End: 1hdPP3-004E7E-Ed
Subject: [f2fs-dev] f2fs: wait_on_all_pages_writeback 4.4 kernel
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

hi, Chao and team:
   we got dump on arm64 that showing a task is sleep on
wait_on_all_pages_writeback
  by checking the sbi->nr_pages, we can see that the value is negative
for F2FS_WB_CP_DATA
  caused the problem to wait .

  can you help to suggest if any reasaon that we are seeing negative
value here  ?

nr_pages = (
        (counter = 0),
        (counter = 30005),
        (counter = 0),
        (counter = 79),
        (counter = 0),
        (counter = 0),
        (counter = 9),
        (counter = -6),
        (counter = 6)),


-000|__switch_to(prev = 0xFFFFFFF74A1F8EC0, next = 0xFFFFFFF8B2C21D80)
-001|__schedule(preempt = FALSE)
-002|need_resched(inline)
-002|schedule()
-003|schedule_timeout(?)
-004|get_current(inline)
-004|io_schedule_timeout(timeout = 0x01F4)
-005|get_pages(inline)
-005|wait_on_all_pages_writeback(sbi = 0xFFFFFFF7A7323000)
-006|do_checkpoint(sbi = 0xFFFFFFF7A7323000, cpc = 0xFFFFFFF760C43C28)
-007|f2fs_write_checkpoint(sbi = 0xFFFFFFF7A7323000, cpc = 0xFFFFFFF760C43C28)
-008|f2fs_sync_fs(sb = 0xFFFFFFF887139800, ?)
-009|f2fs_do_sync_file(?, ?, ?, datasync = 0x0, atomic = TRUE)
-010|is_inode_flag_set(inline)
-010|f2fs_is_atomic_file(inline)
-010|f2fs_ioc_commit_atomic_write(inline)
-010|f2fs_ioctl(filp = 0xFFFFFFF811E4E3C0, ?, ?)
-011|f2fs_compat_ioctl(file = 0xFFFFFFF811E4E3C0, ?, ?)
-012|compat_sys_ioctl(fd = 0xA7, cmd = 0xF502, ?)
-013|oppo_root_check(asm)
-014|__sys_trace(asm)
-015|NSX:0xFFFFFFBFFE7FC7C0(asm)
 -->|exception
-016|NUR:0xEDD8236C(asm)
 ---|end of frame





-- 
Best regards
Kassey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
