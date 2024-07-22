Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20EC3DA5D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jul 2024 01:31:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sVhtY-0007sp-TL;
	Mon, 22 Jul 2024 01:31:20 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sVhtW-0007sU-SM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cNNjF5+k4YcjDq23FQDhcTHhA70Z5ekvmQygtcQU5c4=; b=lvbMuhvoukJD+tCXF7P+IKVX6d
 erS3DbSFoM1bZWexhc14I7pqtKHMYuthQmW3/xfnI9P8SAHd4ibEvoNpbLMBUX2vHirP4FloFNWoU
 cTdjS8TWRYfgggDZ/jNwdTrcB7BcrBu1Nl/+G4G2tTog+E3eT3vvfPNBa7UQANIAWFts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cNNjF5+k4YcjDq23FQDhcTHhA70Z5ekvmQygtcQU5c4=; b=KIDiTdD/uep3OuHUFROe74FzLC
 2hOCEl/UmZ0z0zILu969lVP04i/jUa8XWM/N7IGenDIoOucEgF8nsAmaiMfB+RSMEO9Gi7whPOWsx
 xF98sFRxJy7xljuBelXvuFgrS5pZkn64a5XGAnt6jMv5/scPsuLBrobrJKbVHyQd142k=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sVhtW-000661-2k for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:31:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5F8A6CE0ACD;
 Mon, 22 Jul 2024 01:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7AC116B1;
 Mon, 22 Jul 2024 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721611865;
 bh=Pgdfoi+plDo5Sv3bTklJaLHXbBK8ZHhX9xR+sbaiMhQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hkOOIsmvpuHAylM3fafNyX9Gn3LhzrBn8erzTFGQ9ZBy02HJXjLFkpkI1EUkGuBV2
 aYBm2YapcZDduVx8+HlYNUy6jF/cZ+vpG5qveZroDz55Gidx+7llkY3ubUhYMWL2zH
 pV7TFFM0fUNGKXmcoCJjx15/ClYikEIEVm0sHs/KaFxI28g7KHjHjbUmmtBQyewuyQ
 3JwMMua7ECXOkI4s6LMJcsOrx2lOMFnnpyso6FnNc76/Y/YJM/zEQIgti7vHk51/dG
 j2Kun6/jsqdtrs7heEi1nCDgdO90dKMEdOcvBt1LICZPonsz1Rb7fRvtUo0MtCXtHc
 m74JMPb3appVw==
Message-ID: <e406930d-def7-4e10-91f6-7ff084eac7a2@kernel.org>
Date: Mon, 22 Jul 2024 09:31:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240702062952.28859-1-liaoyuanhong@vivo.com>
 <20240715123451.7918-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240715123451.7918-1-liaoyuanhong@vivo.com>
X-Headers-End: 1sVhtW-000661-2k
Subject: Re: [f2fs-dev] [PATCH v5] f2fs:Add write priority option based on
 zone UFS
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
Cc: linux-kernel@vger.kernel.org, bo.wu@vivo.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/15 20:34, Liao Yuanhong wrote:
> Currently, we are using a mix of traditional UFS and zone UFS to support
> some functionalities that cannot be achieved on zone UFS alone. However,
> there are some issues with this approach. There exists a significant
> performance difference between traditional UFS and zone UFS. Under normal
> usage, we prioritize writes to zone UFS. However, in critical conditions
> (such as when the entire UFS is almost full), we cannot determine whether
> data will be written to traditional UFS or zone UFS. This can lead to
> significant performance fluctuations, which is not conducive to
> development and testing. To address this, we have added an option
> zlu_io_enable under sys with the following three modes:
> 1) zlu_io_enable == 0:Normal mode, prioritize writing to zone UFS;
> 2) zlu_io_enable == 1:Zone UFS only mode, only allow writing to zone UFS;
> 3) zlu_io_enable == 2:Traditional UFS priority mode, prioritize writing to
> traditional UFS.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
