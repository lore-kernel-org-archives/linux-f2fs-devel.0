Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D24FC28B30
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Mar 2025 01:18:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tuLbE-0007z4-Be;
	Tue, 18 Mar 2025 01:18:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tuLbD-0007yw-1a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Mar 2025 01:18:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sDiOO/ddaZrM4JsWcaUfQSmbtWSKN1NyYCBVynSPkPU=; b=AVgI+BXz97y9FKFgHF9VRaO74R
 WrMC7GA4PHrjQYHbIs5gVKUN5fCO4PMlSs1faFBfNCdnjSsA/65Ry2P3X0vIXvEri4c3qSmgvs59n
 PY6hGVYb9YB2AaKN4OJkPh+HR5nDJKBSmIPac5GP+u2QMhOMDLXULWT2/f4Fs6G00vSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sDiOO/ddaZrM4JsWcaUfQSmbtWSKN1NyYCBVynSPkPU=; b=MzafpwSOAE1WPmaUWdz8YFaQ9S
 H0jjhUf/fUYhM4DTKxBxrYADU5F9NWYvxYtzvnu3NCyAxo7stBUZMWdG0nDY/jEKrfaQd2OjyS0F5
 0RIbSkLXh+2jgqqtHSXXy95/zo/Bw/lmtM80osdzAmV9+9elWT7xskB5RZV/Tc87XX9U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tuLbB-0006Iq-Qh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Mar 2025 01:18:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8749F5C5470;
 Tue, 18 Mar 2025 01:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A5C4CEE3;
 Tue, 18 Mar 2025 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742260699;
 bh=fMFPVorHOCpjg8ERi+zcOuznXgzdX23/BT/u3O+grH8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=OMdkQrR98Qcpvubm+QWe38fF8n7fs9ZDTIHcBVb9ta7m1xM+Lpue5wvUnuw5OshEf
 Dhl8qeKhUkaPSAA2EjFgIL3XO+NOBlEZxLIv5wX1+IZ4pP9LwQ1Y3jeC6g3u+CmIlN
 d2FoVgpnjdsjiFr4qtjbtyKfR1m4Ngyoj67Tgu02OMkTwGSpqWP5IS7E1EejEjuH0r
 5KZbtRTiBcZQ++q5QPGnrj3ItAJbRMWkjkKVrfp3FkxhvLj4VmcB/bJoAUPNJADqIg
 sE+eNf15l077oD0PV9GhSRDxzF+ZKCGURXfqQ71RLDy+VhourbkipyoLNY+dTYkMir
 jHjTZ3RIEkRIg==
Message-ID: <5562d492-2ac3-4bd2-b61b-70fea4e1c330@kernel.org>
Date: Tue, 18 Mar 2025 09:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250317133611.457-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20250317133611.457-1-yohan.joung@sk.com>
X-Headers-End: 1tuLbB-0006Iq-Qh
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: optimize f2fs DIO overwrites
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/17/25 21:36, Yohan Joung wrote:
> this is unnecessary when we know we are overwriting already allocated
> blocks and the overhead of starting a transaction can be significant
> especially for multithreaded workloads doing small writes.
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
