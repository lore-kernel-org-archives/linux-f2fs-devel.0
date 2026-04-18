Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939A2F99C6E
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Apr 2026 01:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2MxSAmv0OgPu7TIoYClsaxBcgCfuUgnNx52N4H19LQ=; b=eegi63DcpDIzg/exbyauCZexs7
	t9nELluo6urNn4/KmtOBN5GoZ6ySKGBL9gJr1tUxIXaBmQyhmF6pIh+/zVwX1F2KlsJo9lKZ3yuq5
	utgrzRCk2zsydq4Hem9spj+mJkKa2SRIvW3cZ3r+ptcOeSvOVFR7Uj5sGotDSQuqgqbM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDuED-000792-9b;
	Sat, 18 Apr 2026 01:12:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDuE6-00078p-Gy
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Apr 2026 01:12:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fehGgEB74oTI1A61btjH4oE+JDZCoym/Gg/AwymUZH8=; b=QNABHqE8KIruLJMY6q2Ee8LbZO
 aI3r9IXl7OYZCMP4ROEOY9w6KSmdOFLlJdowzjPiCTXyeVWR4HjYjLQBA1eeNIojF6bxyOrX4kDPL
 txetsulgi5NsN1xc/SUxsHTAxt/msEVx5F9pLC4jxc+gYfd+t6Hyj+IqmWfTSWfZIAoc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fehGgEB74oTI1A61btjH4oE+JDZCoym/Gg/AwymUZH8=; b=hdxPA6msf5wUg1Q/nhpYsJq2/G
 upTxCByrDieOUZvYR7RWbvjsor5Uc+KVA+J5HfvIQAclsISfUZn9/LMizzhiglJhyWIyUBM5Jxm4M
 7XsIFjy2B0brdQkIoLO6HUJ2egN4drYHimJrUe32C0YIyuCc85pRtV4XVi6eUFzt+5TU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDuE5-0004sH-Uk for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Apr 2026 01:12:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 16C6660052;
 Sat, 18 Apr 2026 01:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B4C19425;
 Sat, 18 Apr 2026 01:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776474715;
 bh=wFnksgMRNS6GMTB4eOGZkO/TPEkIJdo0rTfWHVHmeXA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=MOqIDWAvKLY4cyV2MEgW195IS+SDkhAfMwoQO9jr2KBe2RfLgV4u9B/YiCPjPPuul
 kQHQAyDj0uARM6b39LyuHmANdY2Jt3ducxp5G0YwL1AipUf3K/mD1uPRpafUVhbM5j
 LLRsLU65F3jnEBo0I6cVUKjB5gwfGVBV3hplhhVwK5pblsiGGGD1/bj+P0XDpHC3Iq
 RAOfdMcbsy1Nq5bjU+MEUbAFmz7ZlRBCDJkXnVNjrM3IfqjgZn0vUz6f5zZBzVIVz6
 cQV/eeqDlrWN+PO7etdXyo6ixeVmt8TYHymamP8utMHKDTjZykAQUHs8nBS1K8EYUy
 ptDWjCWuA+bCg==
Message-ID: <66c0e8f5-f56c-4abe-9bbe-595487eadf0a@kernel.org>
Date: Sat, 18 Apr 2026 09:11:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Lee <chullee@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260417175040.3562355-1-chullee@google.com>
Content-Language: en-US
In-Reply-To: <20260417175040.3562355-1-chullee@google.com>
X-Headers-End: 1wDuE5-0004sH-Uk
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add page-order information for
 large folio reads in iostat
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/18/2026 1:50 AM, Daniel Lee wrote:
> Track read folio counts by order in F2FS iostat sysfs and tracepoints.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
