Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B5DCCD183
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPn9OOk00BYJiCYHyLQztfowN+SVZZt0DiYEjs+lDTQ=; b=OV52D4qodNoixou0hcBvaVIx1C
	72wfG/bGQg892sxpWzac4lJIDffpcue+WiQYLe0VJBCQTBYNLh686QZIM4xiZFkkDH7HXEMFvberI
	otn1B6UN8MsmZFcEBpHsFXnjeySxv6yZJka76ZV6HrSSqKhzhMcXiynS2NMJ7RvsBLE0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v7Tow-0006QO-MW;
	Sat, 11 Oct 2025 07:15:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1v7Tou-0006QB-EI
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Oct 2025 07:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1pMgVHRa18r26lnEQ4GMbsK7sFq0utkKQ/637RM3eBo=; b=NCCkkSGoIWXa83f+soDz3vBish
 RpRhLYQKElcQtK85XDjUVlfg3H/Vvyd8HEU/QsuYHmoNQgyA8UtjXyK4FDXVfTM7oDPZP4/1Kv9at
 smB5iJbb3zH1J0UWJWgwV3rZhkQDU/Ns9G8EZ9DXUmgnDUh5djZx2RrsYoz87IHcoTd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1pMgVHRa18r26lnEQ4GMbsK7sFq0utkKQ/637RM3eBo=; b=HvjYKSsw+VvTrunF8fetMqTZqK
 uqUigq6GNy+6zpAktNc1XI6K7oMS824Oq0OTk1UEbLg7RyC+AwIPENr3gRfT0siF5Q1/tHKfNG10z
 b/OuqtV9OmaKVlFq3fBkSI/TR9uzpuH3TjxYwtxMTm9Xd4d/eXdXmD0eDy+mqH3R5/vs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v7Tou-0008W0-RG for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Oct 2025 07:15:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 808BD40948;
 Sat, 11 Oct 2025 07:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98313C4CEF4;
 Sat, 11 Oct 2025 07:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760166907;
 bh=zYh5AZNh0giCYqW6m2MfvjvqFnisDhszlZCvD+OJOq8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=p5CLvZVjaSlUBsfhUi8TMFqDbGpmdigWeU0f2DaNoL6NyNzns/vJ6gbl7mykI4gR0
 Nk2GWw8ViL9VTkesLyX7eBYrQtiQ/ez9AwNTfb5QMgSis0KrjTWpsPOd1EzhTgrnQx
 /JqbebVKvVpnf3tZoXlTIKRLo6h32AQyCpvWiSoOAwlMxHohzrTAbwr3q2Ww4z/hf4
 MBWAPaxtr4LFn0IMqtroMFkU0xBIjDD5kZELzRA+e3fHIy8ntGQn7STj1kIW4yiV1c
 cwleRn1DvpKRVRF4+JvXamk4WPDp/ZCn9jbmYBBSJMyqKfVpDUQk/Py3iLu4ZhJ3Fg
 tRlD00i10f44g==
Message-ID: <b5222668-4982-439a-8ecf-7cc5ac12531d@kernel.org>
Date: Sat, 11 Oct 2025 15:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>, 
 fstests@vger.kernel.org
References: <20251006100713.3501501-1-jprusakowski@google.com>
Content-Language: en-US
In-Reply-To: <20251006100713.3501501-1-jprusakowski@google.com>
X-Headers-End: 1v7Tou-0008W0-RG
Subject: Re: [f2fs-dev] [PATCH] f2fs/009: Add delay after killing socket tool
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/6/25 18:07, Jan Prusakowski wrote:
> When running the test in a VM on a host with all CPUs busy, the kill command
> returns before socket tool shuts down. This prevents unmounting the
> scratch, causing the test to fail.
> 
> The added sleep ensures that the socket tool closes before the next test steps.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
