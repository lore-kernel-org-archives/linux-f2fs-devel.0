Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D57606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 00:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DK0rLTjA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B3USqnbh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BFCY3Q3X;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JGjfYqH3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OV7C6MwVyUN+oayP+XRg8Ahu10S7x6c8x+cTjFAVQ6o=; b=DK0rLTjAEztfYi8ST8usVFyGKg
	aXnr8Bmk0QUdc0WvrCnX1rCYjUtYlVzUZb7sy6seyBHSAKWgHy0kgIpujo9XvJS44K/Clv0ECjuSK
	/MxP/hGhijDWut1r16jh20byZhn03Vb9WBn88H8YyeuDapPchEEjMNksob+nAYpEzYYA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLrPG-0000000074j-3GQO;
	Wed, 28 Oct 2026 00:20:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3JyjhagcKAFoAJG86JK8GG8D6.4GE@flex--irogers.bounces.google.com>)
 id 1xLrPG-0000000074d-1MGK
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 00:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=; b=B
 3USqnbhaqLOTOThKc+c0IkxoJZSZDKQtLLAnZMrpeNezTPbt/BrlcmF5GZct7alvb9039bnyebAxK
 p1mjOsXXct8yzI2rnRVb3nibrd87vPv/K3vGTeeZMs1tvl9qSDA1dP30dP78tRdqzBO/RFkCd7A/t
 3UMb7G73b1qRtei0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=; b=BFCY3Q3XCXmN/jnMMzllJ0ghih
 KBxhwhP87PCD97xFHKYRBWAqBd74P2BXvJIzJuoczz6eziZF3fkplc/xo0V21N5qMX+OV8WLXM1h4
 +xdD09RgU7YkOZ+9R7G2qnSSVFug4aFEN2BVaYZd1QQzk/rvxUgTls98dmt/u64cPgH0=;
Received: from mail-qv1-f72.google.com ([209.85.219.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLrPE-000000006fo-3YCX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 00:20:42 +0000
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b529a8610so10545476d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793146835; x=1793751635;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=;
 b=JGjfYqH3KQ9w+lXdYqleswgxmuIQ9++ecAPTiLLsfWJWakJ3+gWjAF46ea7dylUWeH
 ZEJNjQAp2oPetRKgw28qWMZTgTndEV1VYlLOJ5MdCu/XKMDL47+bCjZqnSGz9G7vdaXu
 CP2z3KGMgEIIMCYKEHFbuDeY6gsT4/oHSKcfZVrAjFPIoH1LUDUEmpGk+WwYp+FoJYKE
 84wrVkZsKWA6knS6HsVvyzp5/Oxm1tbTLLmxp8uO2/R84VGbZkNVV4qlkpgbB1OAJjpt
 +a6PwGFYVwLplO7e5px7NpJjccfhY8wEQuoMqCdHEDAH7kEHSXbBSyof5JIojemKHV6T
 swHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793146835; x=1793751635;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36a0/HoL8yXBAoRB1lx62HZinWx8I5wnTQwOiZ4VBGs=;
 b=L2xJJ1D6yADGlNVuy/R3VVS+SajNPCYjsFzrLeUI4mN4375v2C8b8x8/9bSaKYmCo7
 8s7L2O8mwtiXcyDbjsy7VSUlZgoGtb/+LJ6KfIc8XN7btTnGX60UjXBBXhnq4UELkqPF
 hmO7J9k1IXbEYabwA9VT6sA8gJxSCU6qyzuTyL5+F6c449XoNv2wQ2lSWIMt2VWq1+gW
 Hh4JtIUck8jGyD6yQi4/I8fLj23IPUir5qahsaUXn0HWnmaHo4oeHFpWooNqq+pUAfPQ
 woRdiRwoTkXlwF8MyNlDz6Q8nkFZMtCI/uy4e2P0lCr6NQqH/9M/HFfDP9B3C88Fsm0Y
 MKEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy54vx0PSYOAkEFb1fOOSIlcu8P+WS8FulrrrVsvYutptAONvSXVH4Vh8wYNR6kTXUFsJrZoUAm9zbgy7mP32ci@lists.sourceforge.net
X-Gm-Message-State: AFq9FYISd2mKgsLA05Jfm28hzV2Z9ABqf7noTvT5GlmSbj0AKT/1Rs7r
 Ze2AndzHae66wsQQ+FpBtPkFDEjIYp6Kr9SycEvOfQRJePmZsKaPLNZUW1iV5aTupBwLBtff17m
 TusLEUu/rPA==
X-Received: from dycna22.prod.google.com
 ([2002:a05:7300:ea96:b0:369:de3f:acf9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d101:b0:369:5583:bf4c
 with SMTP id 5a478bee46e88-36a200c8c63mr1046676eec.28.1793140775931; Tue, 27
 Oct 2026 15:39:35 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:44 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-10-irogers@google.com>
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xLrPE-000000006fo-3YCX
Subject: [f2fs-dev] [PATCH v2 9/9] kobject: Require explicit initialization
 of struct kobj_type::release
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Ian Rogers via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
 Nelson Escobar <neescoba@cisco.com>, linux-doc@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, llvm@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sebastian Reichel <sre@kernel.org>, gfs2@lists.linux.dev,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-mtd@lists.infradead.org,
 Bill Wendling <morbo@google.com>, Jingbo Xu <jefflexu@163.com>,
 Chunhai Guo <guochunhai@vivo.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Will Deacon <will@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, linux-s390@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 Huisong Li <lihuisong@huawei.com>, xen-devel@lists.xenproject.org,
 Gao Xiang <xiang@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Len Brown <lenb@kernel.org>,
 linux-rdma@vger.kernel.org, Satish Kharat <satishkh@cisco.com>,
 driver-core@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
 linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Johan Hovold <johan@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Joel Becker <jlbec@evilplan.org>,
 Frank Li <Frank.Li@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Heming Zhao <heming.zhao@suse.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-parisc@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, Linus Walleij <linusw@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Mark Fasheh <mark@fasheh.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
 Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org,
 Hongbo Li <hongbohbli@tencent.com>, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed. Note that the kernel will warn you if you forget to provide
  a release() method. Do not try to get rid of this warning by providing
  an \"empty\" release function."

Annotate struct kobj_type::release with __must_init
so the compiler diagnoses any struct kobj_type initializer that omits
.release.

For the remaining legacy struct kobj_type definitions where the kobject
is static, per-CPU, permanent firmware structures, or embedded inside a
devm- or parent-managed structure rather than freed by kobject_put(),
explicitly initialize .release = NULL with a comment documenting why no
release callback is provided.

Where the existing teardown is not safe with CONFIG_DEBUG_KOBJECT_RELEASE,
because the kobject's memory can be freed or cleared while the delayed
kobject cleanup is still pending (ioat, kunpeng_hccs and omapfb display),
the comment says so. Fixing those is left to follow-up patches; this
change does not alter their behavior.

Link: https://lpc.events/event/20/contributions/2392/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                   |  5 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/dma/ioat/sysfs.c                      |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++++
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 +++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 ++
 drivers/parisc/pdc_stable.c                   |  5 +++++
 drivers/power/supply/ab8500_fg.c              |  5 +++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  5 +++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  5 +++++
 fs/erofs/sysfs.c                              | 10 +++++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 +++++
 include/linux/kobject.h                       |  2 +-
 18 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 94e6cd211d70..7a4ac8dd0b86 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -295,6 +295,11 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/*
+	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
+	 * cpuid_cpu_offline() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a99373547126..1948b80e8a4a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -973,6 +973,8 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/* Pre-existing: hotplug->kobj is embedded in static struct acpi_scan_hotplug objects. */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..5ba44876eb96 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,13 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/*
+	 * Pre-existing: ioatdma_chan is freed by release_ioatdma(), not
+	 * by kobject_put(). With CONFIG_DEBUG_KOBJECT_RELEASE the delayed
+	 * kobject cleanup queued by ioat_kobject_del() may run after
+	 * that kfree(), a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 17888cf54447..c2cccd924b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -885,6 +885,11 @@ static const struct attribute_group ualink_xcp_info_group = {
 };
 
 static const struct kobj_type ualink_xcp_info_ktype = {
+	/*
+	 * Pre-existing: xcp->ualink.kobj is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index ab14079d1c42..0847134a1391 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1061,6 +1066,11 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/*
+	 * Pre-existing: xcp is embedded in struct amdgpu_xcp_mgr
+	 * rather than freed individually by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..5a1aca06b542 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,11 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/*
+	 * Pre-existing: sdma_engine is embedded in dd->per_sdma array
+	 * rather than freed by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..df0e48070c2e 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,8 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/* Pre-existing: usnic_ib_qp_grp is embedded in RDMA core-managed struct usnic_ib_qp_grp. */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 6b567a74fc2c..2f530e8c6757 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,11 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/*
+	 * Pre-existing: pdcspath_entry instances are static; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e6b5efdf5dc9..d62411e4f535 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2531,6 +2531,11 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/*
+	 * Pre-existing: fg_kobject is embedded in devm-allocated struct
+	 * ab8500_fg; ab8500_fg_sysfs_exit() only calls kobject_del().
+	 */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..2fb7271dce36 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -305,6 +305,8 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 }
 
 static const struct kobj_type ktype = {
+	/* Pre-existing: permanent firmware kobjects, never freed */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..da7a64c95058 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,13 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/*
+	 * Pre-existing: hccs_port_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1117,13 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/*
+	 * Pre-existing: hccs_die_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1227,13 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/*
+	 * Pre-existing: hccs_chip_info is allocated via devm_kzalloc()
+	 * rather than freed by kobject_put(). With
+	 * CONFIG_DEBUG_KOBJECT_RELEASE the delayed kobject cleanup may run
+	 * after devm frees it on unbind, a use-after-free.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..452920a4e2a9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,13 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/*
+	 * Pre-existing: dssdev->kobj is embedded in struct omap_dss_device
+	 * and zeroed in display_uninit_sysfs() right after kobject_put().
+	 * With CONFIG_DEBUG_KOBJECT_RELEASE that memset() clobbers the
+	 * pending delayed kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..40ec750f4315 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,11 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/*
+	 * Pre-existing: mgr->kobj is embedded in static managers[] and
+	 * zeroed in dss_manager_kobj_uninit().
+	 */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..4d333031b18d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,11 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/*
+	 * Pre-existing: ovl->kobj is embedded in static overlays[];
+	 * dss_overlay_kobj_uninit() drops the kobject ref.
+	 */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..2ea6773cd98f 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,11 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_root is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +252,11 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * Pre-existing: erofs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..6e15695cb75f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1683,6 +1683,11 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/*
+	 * Pre-existing: f2fs_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1697,6 +1702,11 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/*
+	 * Pre-existing: f2fs_feat is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1711,6 +1721,11 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/*
+	 * Pre-existing: f2fs_tune is a static struct kobject; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..ff8a1cf51e72 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,11 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/*
+	 * Pre-existing: mlog_kset is a static struct kset; lifetime
+	 * is not controlled by kobject_put().
+	 */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..8a1332030884 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __must_init;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.0.313.g2479322e68-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
