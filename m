Return-Path: <SRS0=DfLr=PX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7065C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Nov 2021 08:37:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3806103C;
	Thu,  4 Nov 2021 08:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D3806103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1miYFt-0007aS-5x; Thu, 04 Nov 2021 08:37:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1miYFr-0007aH-HQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 08:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+GpnYJchUkODn1rvPiCPu/wbucgl+GyphJcL6xYufrI=; b=SLIV64qgDHr/QOmD8nmGtfTjwi
 BwbSlPkr7Y6kDYKhEbQpnoaOY0UOTLt8EG1bw83p+8nYSg7mWppG2fDIcq/MuiZGOn+oOO1Kpj3+E
 ihKlSc68jsydC3RNi0fATfwNlTHX2D0nRHG+mPYZtwD6ReR9R7knpCb0sn4LRCtF7QHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+GpnYJchUkODn1rvPiCPu/wbucgl+GyphJcL6xYufrI=; b=NG0IeB8667D0ZR4YwZHeHEKrmv
 QjBRAJmGY+7ecHg7RGzIoqUHSKt22+6RwFG0AETesSey5pzO/SiFW0PfIZt9texEmxQ03z2SoTAAm
 OJ25sl+wpIgVsMn70CastqN6uQyPAa58cel1Hnan/MNiR8beWottKzLj7eV989fLemeI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1miYFq-001B4q-PA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Nov 2021 08:37:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 103906103C;
 Thu,  4 Nov 2021 08:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636015065;
 bh=UUdsOFrh+rc0mbbv6xSMpXFRcvxooFtztvPg94FpMFE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QQLDiPwlKQK00b9DSYsRq7gSj8PMyS3nylqUaUcN76Gr3L5cBeJSdjUST+tZh893v
 ymAlIbeZWF9IP0qwkbwuFDHDW/CAOk84T1sYPKDCeEpIkuMBog44bthgp3kpMT31dr
 OnIKDcYyjNcaPHGbpGQiZnaX9D0IWB0Gcr5MCFzYxzqkpj1EdZOyimb1K7/A+14gJK
 /M/dyBlubYu18/KMIszhn8//iAsx5Xb5cBa5ebNrr3wKfLwBbcppY9IZs8oacP2Mja
 +TxDDaz7dBMInLIKffffcrKxu0icseAfV6IG1x0zJreU3GS7acuH5dfm7O/0H5GzbW
 ZUeuMIKtEb7SA==
Message-ID: <b071e877-334e-b669-e2df-abe4d5927418@kernel.org>
Date: Thu, 4 Nov 2021 16:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Dongliang Mu <mudongliangabcd@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Sahitya Tummala <stummala@codeaurora.org>
References: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211104082202.1286551-1-mudongliangabcd@gmail.com>
X-Headers-End: 1miYFq-001B4q-PA
Subject: Re: [f2fs-dev] [PATCH v2] fs: f2fs: fix UAF in
 f2fs_available_free_memory
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/11/4 16:22, Dongliang Mu wrote:
> if2fs_fill_super
> -> f2fs_build_segment_manager
>     -> create_discard_cmd_control
>        -> f2fs_start_discard_thread
> 
> It invokes kthread_run to create a thread and run issue_discard_thread.
> 
> However, if f2fs_build_node_manager fails, the control flow goes to
> free_nm and calls f2fs_destroy_node_manager. This function will free
> sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
> after the deallocation, but before the f2fs_stop_discard_thread, it will
> cause UAF(Use-after-free).
> 
> -> f2fs_destroy_segment_manager
>     -> destroy_discard_cmd_control
>        -> f2fs_stop_discard_thread
> 
> Fix this by stopping discard thread before f2fs_destroy_node_manager.
> 
> Note that, the commit d6d2b491a82e1 introduces the call of
> f2fs_available_free_memory into issue_discard_thread.
> 
> Fixes: d6d2b491a82e ("f2fs: allow to change discard policy based on cached discard cmds")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
