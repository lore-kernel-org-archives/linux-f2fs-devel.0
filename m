Return-Path: <SRS0=H3Ty=PB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851A8C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:53:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444D061108;
	Wed, 13 Oct 2021 14:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 444D061108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mafdK-0002Lr-F4; Wed, 13 Oct 2021 14:53:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mafdI-0002Lk-D8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Oct 2021 14:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMBrj9O+M5bHz1/gmiBdSLL01tsfdFn3sqsSY0dfmho=; b=E3RmkBD+Jq3emHPQYEP7j7Nx1X
 ZXAyA3DR/4khIkNOy/0GmhiR36xgjcJHzKTj+1JnMI+ZNf3OnTVtLAgFPznDlZmuZlHtMo5k3QHOt
 pDFizD0sPd/iRhnShbakMOZzSDeP+GSfvZY3Ts6G5VqIh5udV5H5xBxbx2nW5FhgMQwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LMBrj9O+M5bHz1/gmiBdSLL01tsfdFn3sqsSY0dfmho=; b=hWJovZA4m7E4eZ6M7M/sbH3NhF
 BssK68bEAZCmFcujPiuhZNv9v9ljUDFWjmI/tfWdLAveO7d1lqJjAFID5tnI3yOI2Xwu4/w34vZYT
 ZWojexK3popvfhfL238eg84+VMbyxstHZjDZqZQyK7rulTSLOFBnM2zXBHaOa2SVonLQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mafdH-000073-TD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Oct 2021 14:53:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA2C61108;
 Wed, 13 Oct 2021 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634136802;
 bh=vts1+pm3L+IVnVc2tbBxum1i7/yC4cz23xOk/h10DBU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Spo9ckm5twAnSiHRFdn9Jqx4mjPXgqsWgMlJmgBzF7rhM9LnJlbAv3PtnB2B2X2Ao
 SGrw7P0c2FYvIYUx9ZYKpnb3V9njaOrgErpdR9mNykyaNdwP0fpFQK7qTUWLsPOi0i
 +WVKjiYfI41wvenGyDNAC7LJgL6GUYyDWFOv4EKoEOiCbSCtsOAb3xM+voDyOw3vyU
 Riugklw+CPjvRJRsy89EHYp1MD9x609D7amBs86lzG3CKPu/YZkzOxKw6iJVairC50
 VYi+sBs1zJSi4MgnnKFvT21j7Qzr6W7XUxihZK60IH40/QnsseF+RBlJt3fbBb3mse
 1RdArgGEHcj4Q==
Message-ID: <ee06fd6f-c342-03a8-ced1-4d397af07aeb@kernel.org>
Date: Wed, 13 Oct 2021 22:53:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20211009112744.33698-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211009112744.33698-1-changfengnan@vivo.com>
X-Headers-End: 1mafdH-000073-TD
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: separate buffer and direct io
 in block allocation statistics
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

On 2021/10/9 19:27, Fengnan Chang wrote:
> separate buffer and direct io in block allocation statistics.
> 
> New output will like this:
>             buffer     direct   segments
> IPU:            0          0        N/A
> SSR:            0          0          0
> LFS:            0          0          0
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
