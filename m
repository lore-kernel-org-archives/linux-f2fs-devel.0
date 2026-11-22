Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674F606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g6gpAKD5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IxedowZY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h/RjetIn;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Hc6xFR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:Message-Id:Date:
	Mime-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=epJ91OZG3iN+ZhWOZ4THKTdvwy/2hASO+oEmxnzHXns=; b=g6gpAKD54wtWey
	KeLUktUAg7pxK8CSpzcV8k/mtlFPSqJqBavtUyiwKGCTcAFqnKk1UiGCXb5irYRZONoBx3gCEOKyV
	D1BJx9MUA4jBMlJL/qaF8N3DOx4lYwt7xeNWodRR6LOA+buXqoMGvyWucCY9jkvqk9i5S2VpJcamZ
	XTs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVFdn-000000004fV-3QAm;
	Sun, 22 Nov 2026 22:02:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dakr@kernel.org>) id 1xVFdl-000000004fO-3Q0C
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 22:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:References:From:To:Cc:Subject:
 Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTtlSSaGTpDBtcMHiOircAIvmiTH+Ctop/XsFzGC1x4=; b=IxedowZYsnpkoFrILgH3fBy8Sr
 DreDVXlvVx0tuof/hThbRVN1JT+QMVpUndVs3k8VcfHhi7WFW/M2j6Oq4/HA7u1j63oJvaIhfG9HY
 Ra3QK4z8CacqXtfACeUKWyJ2cZTYmKGPtSH8wyoBlCPibrFl7g/E3TmrCLyA0xzRaY8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:References:From:To:Cc:Subject:Message-Id:Date:Content-Type:
 Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sTtlSSaGTpDBtcMHiOircAIvmiTH+Ctop/XsFzGC1x4=; b=h/RjetIn27m+T8/tpIoFWxvmH4
 ZmoPTZAGH69E+W19siZSgDTeJWB3wHMnDpTr3ZglgkN4zZiB6iAjUUeeGyv8rk6VmNbvjgmDeDk/x
 yf3vYx2uWP5D3EF7N0MNCBcvSQEb+LiCWXN7IcKS/N7BrAypdE7e9hg1YXoU797ypuiw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVFdk-000000007CR-1P39
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 22:02:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A73B7602C2;
 Sun, 22 Nov 2026 22:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB11F000C6;
 Sun, 22 Nov 2026 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795384942;
 bh=sTtlSSaGTpDBtcMHiOircAIvmiTH+Ctop/XsFzGC1x4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=k2Hc6xFRtkicPKFvuKT7zGdEMFSb//oYzAC6yGi4WET4vMctzGLV95ptNtrt42XPr
 WQXnncoUOn8vCWB5V+5BOCSO1YRgvEGvWFlC6kSpFwx64JgBjdDeDjN8t0GAWjAHIl
 OTUhOZXnH51x9+wu6dE5+5xRqac3uNPyE7pzVVKvZEWUvPhn37jeV+RfXXnvGy2n+o
 5fpjybhz8GWsaKNEldr/b1vfp4LchA2oilYAZk48pyxh0hZg4h3t2J1QwAu6uVH9h7
 a22sYJ2GBWGWAOsKWbURM4twq7Z2FvgS7RP2m5XNLf/srWoFugU+HT+1vi7WOYs8uY
 PaUfPtPCWI/6w==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Sun, 22 Nov 2026 23:02:06 +0100
Message-Id: <DN22U90WCTGB.1REAOP1PQUMIQ@kernel.org>
To: "Ian Rogers" <irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261122215639.1178566-1-dakr@kernel.org>
In-Reply-To: <20261122215639.1178566-1-dakr@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVFdk-000000007CR-1P39
Subject: Re: [f2fs-dev] [PATCH v4 0/9] Add __must_init and require explicit
 kobj_type::release
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Danilo Krummrich via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Danilo Krummrich <dakr@kernel.org>
Cc: neescoba@cisco.com, mark@fasheh.com, linux-fbdev@vger.kernel.org,
 Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, Kees Cook <kees@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, llvm@lists.linux.dev, Mimi
 Zohar <zohar@linux.ibm.com>, sre@kernel.org, gfs2@lists.linux.dev,
 joseph.qi@linux.alibaba.com, will@kernel.org, linux-mtd@lists.infradead.org,
 Bill Wendling <morbo@google.com>, agordeev@linux.ibm.com, airlied@gmail.com,
 jgg@ziepe.ca, simona@ffwll.ch, linux-s390@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>, dmaengine@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 dennis.dalessandro@cornelisnetworks.com, linux-sh@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, deller@gmx.de,
 Nayna Jain <nayna@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-omap@vger.kernel.org, lihuisong@huawei.com,
 catalin.marinas@arm.com, Miguel Ojeda <ojeda@kernel.org>,
 xen-devel@lists.xenproject.org, xiang@kernel.org, linusw@kernel.org,
 linux-rdma@vger.kernel.org, satishkh@cisco.com, driver-core@lists.linux.dev,
 gor@linux.ibm.com, linux-pm@vger.kernel.org, hca@linux.ibm.com,
 linux-erofs@lists.ozlabs.org, johan@kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 alexander.deucher@amd.com, Stefano Stabellini <sstabellini@kernel.org>,
 dri-devel@lists.freedesktop.org, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, jaegeuk@kernel.org,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Christophe
 Leroy <chleroy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, James.Bottomley@HansenPartnership.com, Srish
 Srinivasan <ssrish@linux.ibm.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 leon@kernel.org, linux-parisc@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, vkoul@kernel.org,
 Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org,
 Alexander Aring <aahringo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 jlbec@evilplan.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Cc: more people previously Cc'd on v2)

On Sun Nov 22, 2026 at 10:56 PM CET, Danilo Krummrich wrote:
> On Thu, 19 Nov 2026 11:25:11 -0800, Ian Rogers wrote:
>> [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release
>
> Applied, thanks!
>
>   Branch: driver-core-testing
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
>
> [1/9] Compiler Attributes: Add __must_init macro
>       commit: b8a53320a885
> [2/9] powerpc/secvar: Add missing kobject release callback to secvar_ktype
>       commit: 4d5d4dd2a2e2
> [3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
>       commit: d19384f2f3c7
> [4/9] cpufreq: governor: Initialize kobj_type release callback statically
>       commit: 009365942c15
> [5/9] dlm: Wait for kobject release before freeing dlm_ls
>       commit: 48ae948f4285
> [6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
>       commit: ecaf88d385c1
> [7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
>       commit: 25d952902dee
> [8/9] drm/amdkfd: Free queue in procfs_queue_type kobject release callback
>       commit: 6d4ff4a020cf
> [9/9] kobject: Require explicit initialization of struct kobj_type::release
>       commit: 45eeed1f8094
>
> The patches will appear in the next linux-next integration (typically within 24
> hours on weekdays).
>
> The patches are in the driver-core-testing branch and will be promoted to
> driver-core-next after validation.

I've now picked this up; I will keep this series in driver-core-testing for a
few more days before moving it to driver-core-next. Please let me know if there
are any concerns with the series, particularly the comments in patch 9.

Thanks,
Danilo


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
