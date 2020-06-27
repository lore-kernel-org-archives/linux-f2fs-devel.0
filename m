Return-Path: <SRS0=otfG=AI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C24AC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:03:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE7120857
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Jun 2020 07:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="H1rGWOj1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="f/vgrXEz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvUBhtFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE7120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jp4sI-00076n-Tq; Sat, 27 Jun 2020 07:03:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drinkcat@chromium.org>) id 1jp4sG-00076b-Pb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jun 2020 07:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FsrSKJ+gJUACgrGolhsPdd0vgGMvepJqfy8379JcKu4=; b=H1rGWOj1AtZ7X2JuZ2mK7F/DPc
 p+aPAPiPc/TuqkNiXDShstjkMM4fYQSI1EsNJ7cIIGqDTWfEu1jLdSK+XS6FJlbUrp6ggnUny/gRu
 +gfGdPsclHtIzS8cs5iSgZWW0wwixrsYBakibIVsit0Iw619RBLzi4+/rmek3bEhEtO8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FsrSKJ+gJUACgrGolhsPdd0vgGMvepJqfy8379JcKu4=; b=f
 /vgrXEzJjFV/WUx0E62wh5qPwRKorJBDAcdmgStxbOpbKTXgBNSyVkhg1NgYZd0sOSddI6hSKSXfQ
 AIxgZk25shu/D7yvj5Ln7wDeVmGnVzdD+dSAjcZr1x5vaczIKOtIuGJB1qGCUCzEoyWaKy30Ym6of
 bbOdAdhvMMqJ/vVw=;
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jp4sF-002RNk-IL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jun 2020 07:03:40 +0000
Received: by mail-pf1-f193.google.com with SMTP id a127so5614251pfa.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 Jun 2020 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FsrSKJ+gJUACgrGolhsPdd0vgGMvepJqfy8379JcKu4=;
 b=EvUBhtFbdA5q/Ln7/JmYkJ4WCSQYr0FDka6B0ToibqDo+KoRIWa5csnmBSRVgeVZpD
 3SycW07fCAwTdh+u5tC0gQuOD9UiiaFw8Pzh8+WwWoF+ppc6VrAXas0XCfYV9gXA5Cah
 O5dfGYTYYOddR91unI7zbYt5VMmXuBus/0h6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FsrSKJ+gJUACgrGolhsPdd0vgGMvepJqfy8379JcKu4=;
 b=tvsD5NGt9XmPMh1b+BOzsU4bPPKDCGRslx8s8uT87CSaMrCcTvIYa+BdofQUEYdFJy
 4SZq9BYi57vbefenaW/DjB0a+BCH+tBtEpiZ5Cq3f+Nq4k80SvJt65fJ9q2vp6KTfcYz
 nXLbspCLURCfo+ZvASe/PIQc+Kk5beK+tDX9cjW8hA0j1d1mun0kHGyHJhzIv2lzp1qU
 pT+nCZjhGMz9Lz/tjiBUYFTnPC0wFvAYuhn5/YVxICLFg/nTYD1hM3Ik0T1z+MS8VSga
 7z4hNM9U6RQroDk36upDZecFk/N8d1TEPYgadaXQlpPaq76UbTXewVGe9A49QDRO+dzv
 g+Cw==
X-Gm-Message-State: AOAM532deP8OS0PXfQhfAsaz1z8aMw1smv7i/A5n0KFW9J2qWNYHKIIz
 HMlYpWPagpzT1PAFqwydbOOSHQ==
X-Google-Smtp-Source: ABdhPJyZFG/mi1UZ8xodyex8KRwcp8OsluVaczS/+idWJyqCQQeS3g8ufLKi4ZbrLW2qKEXgiYfBLw==
X-Received: by 2002:a62:5c85:: with SMTP id q127mr5814143pfb.311.1593241406667; 
 Sat, 27 Jun 2020 00:03:26 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com
 ([2401:fa00:1:b:d8b7:33af:adcb:b648])
 by smtp.gmail.com with ESMTPSA id u4sm28133269pfl.102.2020.06.27.00.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 00:03:25 -0700 (PDT)
From: Nicolas Boichat <drinkcat@chromium.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 27 Jun 2020 15:03:03 +0800
Message-Id: <20200627070307.516803-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
X-Headers-End: 1jp4sF-002RNk-IL
Subject: [f2fs-dev] [PATCH 0/4] Detect and remove trace_printk
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
Cc: Peter Chen <peter.chen@nxp.com>,
 "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
 Rafael Aquini <aquini@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Howells <dhowells@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Will Deacon <will@kernel.org>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Boichat <drinkcat@chromium.org>, Jayshri Pawar <jpawar@cadence.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Andy Gross <agross@kernel.org>,
 Tomas Winkler <tomas.winkler@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-media@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>,
 Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Colin Ian King <colin.king@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Divya Indi <divya.indi@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

trace_printk is meant as a debugging tool, and should not be
compiled into production code without specific debug Kconfig
options enabled or source code changes.

Patches 1 to 3 remove/disable trace_printk that should not
be enabled by default.

Patch 4 adds a config option that can be used to detect such
trace_printk at compile time (instead of printing a nasty
warning at runtime).

Nicolas Boichat (4):
  usb: cdns3: gadget: Replace trace_printk by dev_dbg
  media: atomisp: Replace trace_printk by pr_info
  media: camss: vfe: Use trace_printk for debugging only
  kernel/trace: Add TRACING_ALLOW_PRINTK config option

 drivers/gpu/drm/i915/Kconfig.debug              |  4 ++--
 .../media/platform/qcom/camss/camss-vfe-4-1.c   |  2 ++
 .../media/platform/qcom/camss/camss-vfe-4-7.c   |  2 ++
 drivers/staging/media/atomisp/pci/hmm/hmm.c     | 10 +++++-----
 drivers/usb/cdns3/gadget.c                      |  2 +-
 fs/f2fs/Kconfig                                 |  1 +
 include/linux/kernel.h                          | 17 ++++++++++++++++-
 kernel/trace/Kconfig                            | 10 ++++++++++
 samples/Kconfig                                 |  2 ++
 9 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
