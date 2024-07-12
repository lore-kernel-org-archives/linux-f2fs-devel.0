Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE2CC2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jul 2024 07:15:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sSAUl-0004fp-22;
	Fri, 12 Jul 2024 07:15:06 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sSAUj-0004fi-FV
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jul 2024 07:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1hLdJgvTYvWoiU6ARA4PYoczTa2DDxNfZdg5JtNOwNI=; b=SB37NCRzgnApWNHirjEJusAK95
 wUwBVj5che7KUgpXZTnC1zqj0RbqEykXGkZNwQXMwITC1bnPW7foaIrfgCr38mhs3jTPs83liiNNH
 1PvF5vx9GSdy8BsroeDXxJAPuzG++YUgMK/CnDJpU0YqDh5iLEZMFA0BvEdZFFQ6ORrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1hLdJgvTYvWoiU6ARA4PYoczTa2DDxNfZdg5JtNOwNI=; b=j90lCDI4ay4TIVA6RphPCmBS5k
 084buPD3bTRH6ztLMIzLEFjINj+RNChHs1VwPGHIWqOZv40QtOp6sEyWKxpS/3O8bN9WFc5h0nVKy
 JoojL7Mxfci3BhQw+Sq5shYC49qnhoUNjN9Y/wUM6sIDLy79sDsKN4mdU345PKCLBsWo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sSAUj-0004qA-2F for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jul 2024 07:15:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ECEE961E1B;
 Fri, 12 Jul 2024 07:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C1CC3277B;
 Fri, 12 Jul 2024 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720768498;
 bh=1hLdJgvTYvWoiU6ARA4PYoczTa2DDxNfZdg5JtNOwNI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rbnkqQ5Zqfhjn4rbM5VlTs7CP+FJC0lvGnzJA0y3h5wda2AFrEBXEu683cBhqoZXY
 RWEsvLHRHK8NXs1a09kpzEKy5ohx0glcN9dhhn/ZQp5BTe5RZrJPdvFCNotxzqW9rz
 0lwE8nsBhNkO8zYncDUztwm+u5mk6H7d/qxKe/E8vRL5YkF3zvf+4Kr4jYWCOjNIBt
 QsK24IZybvCUOqZ8GNpurUl0HYHT/vyTkip5Zp3Ptu0j2mRjL4SREp+Ak0v6bhhm4u
 A/cZjISITXw++VDcpzD8YMPLNjDgYM+O9wTtLu4PSQMPVmC4cOamYgRX56dHsWs6UC
 j8Pwjo447TTsA==
Message-ID: <b0078002-bf06-4fc2-80ce-aa568cdfdea6@kernel.org>
Date: Fri, 12 Jul 2024 15:14:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240712020133.140148-1-shengyong@oppo.com>
 <20240712020133.140148-3-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240712020133.140148-3-shengyong@oppo.com>
X-Headers-End: 1sSAUj-0004qA-2F
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: check all-zero inline data with
 helper is_zeroed
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

On 2024/7/12 10:01, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
