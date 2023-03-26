Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A15C74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 14:00:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgQus-0004uU-6Z;
	Sun, 26 Mar 2023 14:00:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pgQun-0004uG-Hr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 14:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z+5wZRkGUGJ6hfDTRxK4jO7/bIFqoWChYDUb20tHiRg=; b=mh1hm+3l0V+1DrEJZ5Ehlx0oFL
 CeXwS6Soejqx+ncp20M8KCiUmrTua9kLklBkZ1C0RhZHpPnYN53KWNq6bR6G04MqNBII8/dvxYT4T
 p5k35VZoYCVqrJEW4cAyC/rjxkawu7roma0Jdq5QO79KRnNsarhJyIBZ+d0i9xlGZkHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z+5wZRkGUGJ6hfDTRxK4jO7/bIFqoWChYDUb20tHiRg=; b=Z6ICwPqAKTcfM0YfOmTLglfS4T
 smU6M3/0IcNXRlDK5Zf3EXg3wOm9bztVdon+B8YDZXQ3RuMw9gFTbe3proaWdKpjpZ3ZdJM1Bq4ul
 7X4ZSB7Jzqp2En30UY4qdKL3cMFJ3WEhJg8hsfk19yMo8dwkZWUO2ulVchl98Ywoj/AI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgQun-0004VZ-Rd for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 14:00:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 75D5660BA4;
 Sun, 26 Mar 2023 14:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4299C433EF;
 Sun, 26 Mar 2023 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679839203;
 bh=zg9Q/WlwwDcQ03sBlZkOi7LNesDtc2iN/FX8inpVUd0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dvSbUHYUSMOoCM3sBQfPNhRqE3Kum/Wj8tcTBaxh1GfH/Md0iJ3Vr+HpBIs6l2Whq
 MLLLmTL+5uKphwWI1hn1g+9i5lH+F+q1qfTuP+q1XzNPnYbOtz3x9/zPpuNcyHCSTL
 Cfh2Lp8HTi/s7ysteRHhfHycXkaRJSBm6Ha+3kzpUfPIr3JHQOpTk/7RT9UViOHw1s
 05DAJ4D4VHvXxObMwXYlI60tAzvgCzwcBNIKKdCh6Oi9LEOzqqX3jRBoG3r8GdWRME
 T7ieQuL3duWb21cQ2FJbBnKNveuktJeEwl8aqcQ3Un5Yy3Px7CWBGlEhCbAK44IRC+
 /FLCTbW21hhGw==
Message-ID: <b3b2a78d-ff3d-0f66-801a-b9a95c22fb70@kernel.org>
Date: Sun, 26 Mar 2023 22:00:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230319075130.24962-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230319075130.24962-1-frank.li@vivo.com>
X-Headers-End: 1pgQun-0004VZ-Rd
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add compression feature check for
 all compress mount opt
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

On 2023/3/19 15:51, Yangtao Li wrote:
> Opt_compress_chksum, Opt_compress_mode and Opt_compress_cache
> lack the necessary check to see if the image supports compression,
> let's add it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
