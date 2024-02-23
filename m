Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F3CC54798
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:05:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rdZvD-0001ZR-GI;
	Fri, 23 Feb 2024 18:05:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <SRS0=wkxO=KA=goodmis.org=rostedt@kernel.org>)
 id 1rdZvC-0001ZH-IR; Fri, 23 Feb 2024 18:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J/OB4XMoTTzaS33yyZYU/yTd1EPc1V7tnLLT0eWZd4A=; b=RBQGXcVJ1DpTyj1qMU7KLVE3OJ
 g7dZnXHawEPFkiBIhBMkroVDsZbj3UyAZ7Dfgg6ir7M356p7VBG7lRs3u8O4wA3mh5Rr3i8c4W2dr
 bx6WwnF7MyTwGEh/VmZc9zmV9fJ6XcYE2GWTWBWL7BPA2v4xw7UfYHWmrwXmmkDw9ioU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J/OB4XMoTTzaS33yyZYU/yTd1EPc1V7tnLLT0eWZd4A=; b=bAZl8mEi8jM5oTx9fU5DRuul50
 N9r+EMsh69bdDsYn6jxzAZTnH/WuWVAK0lVbugLpGXfsx7iUzNVmSrjfrk+JfTpRuFXnvvnCDKaLy
 FUIn0CptHCB0E4/446pOpoYsij6mtoxrrxmf3kd/xXDkORNZXe0O51dqeZ6IE/Z7WNAY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rdZv6-0000Rf-9J; Fri, 23 Feb 2024 18:05:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CC73ECE2E24;
 Fri, 23 Feb 2024 18:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370BEC433C7;
 Fri, 23 Feb 2024 18:05:01 +0000 (UTC)
Date: Fri, 23 Feb 2024 13:06:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Message-ID: <20240223130653.2cc317a8@gandalf.local.home>
In-Reply-To: <20240223125634.2888c973@gandalf.local.home>
References: <20240223125634.2888c973@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1rdZv6-0000Rf-9J
Subject: Re: [f2fs-dev] [FYI][PATCH] tracing/treewide: Remove second
 parameter of __assign_str()
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
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ath10k@lists.infradead.org,
 Julia Lawall <Julia.Lawall@inria.fr>, linux-s390@vger.kernel.org,
 dev@openvswitch.org, linux-cifs@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-rdma@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, io-uring@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux.dev,
 ath11k@lists.infradead.org, linux-media@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-pm@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-erofs@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-block@vger.kernel.org,
 ocfs2-devel@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-cxl@vger.kernel.org,
 linux-tegra@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, linuxppc-dev@lists.ozlabs.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ath12k@lists.infradead.org,
 tipc-discussion@lists.sourceforge.net, Masami Hiramatsu <mhiramat@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, 23 Feb 2024 12:56:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Note, the same updates will need to be done for:
> 
>   __assign_str_len()
>   __assign_rel_str()
>   __assign_rel_str_len()

Correction: The below macros do not pass in their source to the entry
macros, so they will not need to be updated.

-- Steve

>   __assign_bitmask()
>   __assign_rel_bitmask()
>   __assign_cpumask()
>   __assign_rel_cpumask()



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
