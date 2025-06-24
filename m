Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAD4C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Jun 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/cB3kd74Y6MFrHoKpon59Z9eo1Sm7ymUL+enCtfi3s=; b=NlJhsSM8ZPzFNzZXFOU9wN/fgd
	daq/ZCFJg4uEnqLrGhLUeDpjmelHwqDiEEBb8K7reya2flaQFFhcPorrAiSeFcv1jF+z1SH4mfUgJ
	2WQoiruGRtaImVLQXrIjK+VTzLbfJhtIckxdMtIR9Pzmu5JN5dl8zrSYkqRXuRWzI/OM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uU4BS-0005Ko-Po;
	Tue, 24 Jun 2025 13:59:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uU4BR-0005Kh-6E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 13:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G2SoSyZl/SHINR94zlghpQNrLOC8Fi1TDe+AX2rCkIA=; b=KsFzbBXY1CE+CCGh7YvAipPpcX
 +Se+c401oIB94L2HzkB6QeXxvcPKoDsWvTp5b3Prn/IpxMn2wd4QI+IBMM8dscQH+r8NSRtRLsBb3
 CNppWIE8R5zBehHnkj3a+KDGnYPiWwgNcIZq34VMgNhT7xOdMFemmgT9jdz9WoPAqjk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G2SoSyZl/SHINR94zlghpQNrLOC8Fi1TDe+AX2rCkIA=; b=YT3T22sKMK7Plz/UPjXpdwej+k
 bPL7TPu3dTZxXD3Yb1C+Wfcj/By/cRWK0El/3ojM2sqOwaQN+wXe+pEHaQjqHNVFy3obALKsh9D8q
 l+dGWVQ7yjTGwtldaZBQjwPcMLuyVIQSPtDDh0C0haqbN+oSd89Ib/v3Ty0ntzljFI5Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uU4BQ-0003Iu-RM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Jun 2025 13:59:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 35095629D1;
 Tue, 24 Jun 2025 13:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A4C4CEE3;
 Tue, 24 Jun 2025 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750773566;
 bh=/Gyc5091KzQg/q17GrBJ5edGPnJe/JOe8V92hRTFeCE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=pM19i3t6tZ0p/u4nT2IZxtnyDBOzqMQyZw2WthHRvxBrmwmZaVaZGji3SiJM6+28a
 PUr4/MY1LWbuSbwpa36DJzJGqWSo2NYJLjfG36tqr5ixjjNMi95qpnwtqlGEa2gBGz
 9LmIZuKTHCTbfujTbPbTaASqSy0Te39aA3VMAnYjJ1XsaLCL6KaYX7fZW3Osc81PEO
 Vx2haExHwYBDr2q5QCXHpX8aT/h9LDxhP50IarR7tMU0WPiti+RDQJNAlZeAA9uuy2
 15GSUfEfn0/Ci5+9w7W2UyGfElNyHqX1j61+PWpa/Vx7jo2IsCWYR259sAERWaJYMk
 EuyUs7soa288Q==
Message-ID: <aa15ae08-4875-4349-9cc0-ffa0491afa58@kernel.org>
Date: Tue, 24 Jun 2025 21:59:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Swarna Prabhu <sw.prabhu6@gmail.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250617174047.1511951-1-s.prabhu@samsung.com>
Content-Language: en-US
In-Reply-To: <20250617174047.1511951-1-s.prabhu@samsung.com>
X-Headers-End: 1uU4BQ-0003Iu-RM
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix the typos in comments
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: mcgrof@kernel.org, Swarna Prabhu <s.prabhu@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/6/18 01:40, Swarna Prabhu wrote:
> This patch fixes minor typos in comments in f2fs.
> 
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
