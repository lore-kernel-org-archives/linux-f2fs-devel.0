Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0038C52D7B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Aug 2024 03:55:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sdidE-00021h-Rb;
	Tue, 13 Aug 2024 03:55:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sdidD-00021b-BJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Aug 2024 03:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=he1Y4T96CJOnVupvJuHLWS4g3gQ7kfPApat/HQ0Mc5c=; b=Kugo7ExlHBu//AAGQEiHshlpLM
 6dXgp9kJGjWn34F8xCaousNyHvsPNezgOBGoYl1SNoiEAheglWxEWl55ywQbsjQxd/DtjG2RO6hxB
 7pchpYMcxajZiwiD695efJrx5h8ASp1s8NtOdDCWMvRK38qEv6YVA3bRrZzdPFnvVNqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=he1Y4T96CJOnVupvJuHLWS4g3gQ7kfPApat/HQ0Mc5c=; b=El5tBKtfXM3zpIrj5QaO1A7vg2
 9aUVxi/DViNdAhnwwop6fOKZntN3yLYlNFDQeTKspisDuFbOyQGFo5VM3awfsB6DNwAxMLvMpXEyt
 9yZB307es3Fh3U3+aK6UzADNx5Bns3YupPW2EkEX/mtr3ZaxYts5ezTZUO63tuQUO/V8=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sdidC-0004Vb-IV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Aug 2024 03:55:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D36D3CE1116;
 Tue, 13 Aug 2024 03:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C496C4AF0B;
 Tue, 13 Aug 2024 03:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723521327;
 bh=Z0I626lWaGthR2/U9L7aJJ9GQccyrjgVcdlIdI1joWc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aV0oDHo7pLZfmJcVqSbL/6QVFptuRVXDUbd8eXDJn5pZTZf9KhR+7aX75iK63IzeN
 9cFcEh1U0lnDkWthKLmU8oH6SK1LrL3qHfwmL+oCjNpaAepKPaYnVjOm4e7HRy00v6
 nF3tn+p1/8C8tcNdbTewM+k2wn3714G46egKhe+JH+aTlUTpYP5dZcKB9F9UlINczy
 ISBr7U7I6/vHnC833xJUKB39UYLtGPMZ7jNBMp7nVTmtz6gjGyzjhnMYkoSGyJvBX6
 NhYvmYS6LQd+osAFBHsk6+dW+BD834sEL+kM4MfnQn9okQ5myLVgqX6h36LsTN0PkN
 2xuXFEfQBhJWA==
Message-ID: <4d9cce2b-b3e8-43b6-b737-625e7088fe1a@kernel.org>
Date: Tue, 13 Aug 2024 11:55:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zhangxirui <xirui.zhang@vivo.com>, jaegeuk@kernel.org
References: <20240801091822.3853678-1-xirui.zhang@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240801091822.3853678-1-xirui.zhang@vivo.com>
X-Headers-End: 1sdidC-0004Vb-IV
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: reduce overprov_segment_count
 set times
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/8/1 17:18, zhangxirui wrote:
> If overprov_segment_count < rsvd_segment_count will
> set_cp(overprov_segment_count) twice, reduce it.
> 
> Signed-off-by: zhangxirui <xirui.zhang@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
