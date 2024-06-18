Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5918C2BA15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2024 08:09:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJTu2-0000eI-LO;
	Tue, 18 Jun 2024 08:09:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sJTu1-0000eA-CZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 08:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7e9jQFk656vxcvtS5wKu3eapUDJzdRRfPmEc/n8le6Q=; b=dyLzqWt+vdPC45U2cZD5XWSkvI
 DaTRO7OUd1jfqJ2kdFcZKaKOXybtKZuLtLh992ybQ2R/3DtAsZWXbfjNbSVeC/NW3W9vwvHgdy5Oy
 5BZMyzHk+L18sLs3zSmR31nn40eFLPD1F/sEeb+96ntuxdNGhVCQmBcI6qrqmYQSlFek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7e9jQFk656vxcvtS5wKu3eapUDJzdRRfPmEc/n8le6Q=; b=DL3dUYAtydlGYuame9yWu+H79K
 APaOrwPfZY4pUw8QKMXK8OM50HeAt4+3+i5tr7J+thYd+A9ftUYkKuLUa1HvmBOz1e78he2uKSzLf
 I7UjeJ84kEeXJ5bpc25Uzmq9Jjt1pC0WWEm135RcP2coZpZ2cXQr+nmo8AAC1Ov6DnG4=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sJTtz-0006kf-VB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 08:09:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7BD52CE0B5A;
 Tue, 18 Jun 2024 08:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A7C3277B;
 Tue, 18 Jun 2024 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718698147;
 bh=Me7HXSrT1mn4Xb+2uvfuq5JsAE1wR88izfxdR2nfLAU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zsog6wNK++pvGuCZs5pQcEaKfoZrI5hH9igp1UKcQJQ59eLAzkjNc190BJ0FkrZCa
 eH2YmVUXVBYNYkdS6qc4kxTY+d0oqp51+fSerEF1nUVZGNj+q0z9+nLAXOel09dZ+1
 yDD1AZznRCvC4zvHh71GZJZXxhGC2jrwjloyUvEIdpTP+DaRnz+rE3+KvP5h4EGlGe
 I+U2qIEhahwS8Z+QL9HtIC+RxGAwnl6PO2XMB57sWRnm+G/NGW1osK0+NI5S4Jp4FU
 0N4rfQEGRb+ExiZ4ULOE4Yx8LdilLozCEaYdNhpJWqlBfe84Vj8FPt672BKS6OvwBO
 9rryqEngWtOwQ==
Message-ID: <a657cf9c-e8f6-4eae-874e-e6f2f734e390@kernel.org>
Date: Tue, 18 Jun 2024 16:09:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
X-Headers-End: 1sJTtz-0006kf-VB
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix do_set_verity ioctl fail
 issue
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
Cc: ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com, hao_hao.wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/17 15:11, Xiuhong Wang wrote:
> When using the f2fs_io tool to set_verity, it will fail as follows:
> unisc:/data # ./f2fs_io set_verity file
> FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
> this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
> the passed parameters do not match the latest kernel version.
> 
> After patch:
> unisoc:/data # ./f2fs_io set_verity file
> Set fsverity bit to file
> unisoc:/data # ./f2fs_io getflags file
> get a flag on file ret=0, flags=verity
> 
> Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
