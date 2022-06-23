Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E8FCCA47C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jun 2022 18:12:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o4RJa-0004TP-JZ; Thu, 23 Jun 2022 18:12:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <bart.vanassche@gmail.com>) id 1o4RJZ-0004TJ-Ny
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 18:12:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMWv460Wb54wONmzPP5cv9DMKvBsyAs+kVlkOJ0bxi8=; b=Sq1tNAaooPQmP3tYE39m4dWUot
 6LB3Y6+h8e7UV4rTUzLsm5WH27z+3OE7zZsrNFdGVbobQ67IlL8lhnQ/usTMkEkgVaAjEDoAh4XZj
 H669Koo5ddoa9vqRe3EentsCjS9zD2TWJJ30lWvlB6vpQbqWXqchRradyOtWZgre76E8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KMWv460Wb54wONmzPP5cv9DMKvBsyAs+kVlkOJ0bxi8=; b=X
 HW59Hlr86XloWWd5SWljYXU++vtG5A4L2bbdYpA0lEVDFyr3M8Vxpr7HUPLnJ45XLrPRjdCXmP7dX
 Oa3p48el0w7ypEq2XHpuAMB91Wz8x/kQNhUSSKabf3xzhQzciKg1QEeOLOoHyDXwBRMXWTXXbXHAJ
 eJD6zxtYo+WN4Q4o=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o4RJW-00BS7r-Il
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jun 2022 18:12:24 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 73-20020a17090a0fcf00b001eaee69f600so381689pjz.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jun 2022 11:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KMWv460Wb54wONmzPP5cv9DMKvBsyAs+kVlkOJ0bxi8=;
 b=TjeTzvnpneQHIu7YhDTYJeni8Kti1dl1RmM1u/XHVXhFGix1+OvaUoaQlE8+pw3NRl
 ogb+YF1i+KyinLVnjqAsL1Qo+gfZZOtTr6eGOX0CjGU0vLkcglxOvQ1SXxu5+Dnqmyjl
 6GjcSK0ky8GivL4e2lhlH2l9i9XkLQBLJM2qro9OFc2LkxEk5bqmtOJN34PnXfK6jJ9L
 pBjKnBhlEZODmtvKk6MR/uW7Eu0v0ump5Af3ODd5VEgc5M77OcIUTleXP3hRnIS0zDhs
 5yqsQPASIjSGccivv/FeAIoY2NiSYTKI0vj79gjTaRv+gCZql1E9KZiaNbwo82pWd8IK
 rr2w==
X-Gm-Message-State: AJIora8mlL91eP0OxaRFlqKutqAFGmX/vuwyW8ruH3b5EMZIf001skMJ
 vSQm8pZ241D/7xC/3lMFknIJYJWDtVFeFA==
X-Google-Smtp-Source: AGRyM1tW41AxQDe+woj4wtDofSa5GPmC2UXi8C2jMm322n9K/9epPT/fMzVq1mG0CC0sYoCSmcd4Zg==
X-Received: by 2002:a17:902:7486:b0:16a:cfc:7f49 with SMTP id
 h6-20020a170902748600b0016a0cfc7f49mr30868893pll.135.1656007936971; 
 Thu, 23 Jun 2022 11:12:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:70af:1dc5:d20:a563])
 by smtp.gmail.com with ESMTPSA id
 az8-20020a170902a58800b00163d76696e1sm104803plb.102.2022.06.23.11.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 11:12:16 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 23 Jun 2022 11:12:03 -0700
Message-Id: <20220623181208.3596448-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
X-Headers-End: 1o4RJW-00BS7r-Il
Subject: [f2fs-dev] [PATCH v2 0/5] PAGE_SIZE and zoned storage related
 improvements
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

This patch series fixes one issue reported by Peter Collingbourne and a few
issues I discovered by reading the zoned block device source code. Please
consider these patches for inclusion in the official f2fs-tools repository.

Thanks,

Bart.

Bart Van Assche (5):
  Fix the struct f2fs_dentry_block definition
  Fix f2fs_report_zone()
  Improve compile-time type checking for f2fs_report_zone()
  Use F2FS_BLKSIZE for dev_read_block() buffers
  Use F2FS_BLKSIZE as the size of struct f2fs_summary_block

 fsck/mount.c        | 14 +++++++-------
 include/f2fs_fs.h   |  8 +++++---
 lib/libf2fs_zoned.c | 23 +++++++++++++++--------
 3 files changed, 27 insertions(+), 18 deletions(-)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
