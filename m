Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F9C2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2024 02:34:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOTLd-0001Zq-VS;
	Tue, 02 Jul 2024 02:34:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sOTLc-0001ZY-Ut
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 02:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBtFNeNRMXq+MHEhij7Zd6Wm3lLAJ+it114RD1dkkgk=; b=gyPOkEXqhcwQq6EgT5x8NCfK1j
 ugh9wGZTlVSSRHcjY+rL+koip3nqvGqXaCzXBOqY3PvA5tsdaGV8OpFYIeiUV79i+XE6ORHBb1cOF
 lGRi5UkFS0EXwgKXr0gNdWq9Z/tcSa+Cv7jd7ixd+orJsWFwn49NSIO5KgP9hC6a6Zwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hBtFNeNRMXq+MHEhij7Zd6Wm3lLAJ+it114RD1dkkgk=; b=Qyr6MILnR5GJjtYo3PWDNsyTAr
 +dDUUkurDTHHvEpFG7qn7/dQmXjxZwQYvFqkduuzzumovtHy2HFluUwYT24HQ5D6IB2LC7+Cy23le
 6fzBMtdxzUBNoRyAGmQE3b687yee9wNcJ5FQ21muSQEuWniab6YENnb/Q/HRYmmH6e10=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOTLd-0007iZ-EN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 02:34:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 551836142E;
 Tue,  2 Jul 2024 02:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DFFC116B1;
 Tue,  2 Jul 2024 02:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719887654;
 bh=hBtFNeNRMXq+MHEhij7Zd6Wm3lLAJ+it114RD1dkkgk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DU94VWtEtOudmL2M+fa4QPLtJlZZGNJdbVeirkCct68hKeF+AXQWRFXTo30Ikv2XY
 gr9k+rfpRAjCM4o/Pt+BteTzt2y0pco3IXOm4/xJxXjE/RUccq+SGwHBCx9bQwAOrj
 IdN3HgWf4gpPlLnknKnQrHuS0sGn54Z35p+i63E326E8RAfbD07Tgt7m74vEg90r4Q
 OZ+8U4Y1JSRRxMPinAizJu3LKoc4q+mI9JPobw/LmuDuyzr831A1OrTiFlCK89TDgp
 1rdyA/yCugx4aVZERptNX5uVa478uYwfQdAyxQtQL+Yif3wCT53vZ/Tvt/XjISZ33L
 RjaD7PulUI+3w==
Message-ID: <af7a98fb-9f52-435e-981a-64c8814fd630@kernel.org>
Date: Tue, 2 Jul 2024 10:34:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240628013140.2444209-1-shengyong@oppo.com>
 <20240628013140.2444209-2-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240628013140.2444209-2-shengyong@oppo.com>
X-Headers-End: 1sOTLd-0007iZ-EN
Subject: Re: [f2fs-dev] [RFC PATCH v2 01/10] f2fs-tools: export is_digits
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

On 2024/6/28 9:31, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
