Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E42C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Apr 2023 16:28:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ps4Tb-0005Au-EC;
	Thu, 27 Apr 2023 16:28:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ps4Ta-0005An-RV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 16:28:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ovY5SMBcqEU+CyT1KhOmMG7PTkkNuLj7MmOlbE1w+WY=; b=FW7M/6VTBEmIkQCb5gdtTdhUrm
 5Vmv3q5iNh8r2sQ4wTwmZJ+fc25qAfVnXQYzSNg92qJyYOk2pj9tli1A5UlrRtpvbfle2ZCLg2INg
 87tAn8iLGgKCd9KbVJFDTGrVfJmroiZIJ40xnxdi0ReDGB2jd07OlOlDjCYlaONYjBJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ovY5SMBcqEU+CyT1KhOmMG7PTkkNuLj7MmOlbE1w+WY=; b=mx0xwEXaFAZOqn0x+cepn267lu
 XMiDFLZu4UDI6Mkx2sOX12pg7oBozbjZ0xgof3zKtVRLinHTI565/OUpHLToQNnpELsX51J/pdVRm
 TBIzxJFUP+Qj0Nf9ctxvnIIA2mScKAtBj2mbNf/2rqlrsPcgTijQkNf3AQVCe2oEcL3E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ps4TZ-003k44-De for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 16:28:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 39DA260F1D;
 Thu, 27 Apr 2023 16:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D74BC433D2;
 Thu, 27 Apr 2023 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682612882;
 bh=sygxyc6bJpU/G8GGd4Uas2ekQmIkPh/RJ/FhruQwGxM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tFjZdV7zhl9uUumZNfu0wBVvnGeZ2hwcuYdUN4cf//dFpowtme6rbXEsEHLh0YcRK
 vU5p9Kzih3lZmZRRAj1SbjOi3YRch9UCalQ5Bh9EzjKrjEwZ35lrNsCEHRhn5DGrFZ
 LU38paKFxKW0TjPidBaqC25hjJO5Z/+QIb8uXcfLVQgdcssXoxGd2MqSvWpBd18ZMz
 dqU5CwLLn/8kT1jvVgKHx5gB78yePAFm+ObHhRtGGYbRURiXn0Rw2m4VdYWnrH+jaX
 OBqdRS6XqwMn99jLMcKHqI1I+a9Q1ZljRMmASgfnIvLx5VY3fqDP1DmCoMUj1+PbRu
 DpT4sC3ILgVGw==
Date: Thu, 27 Apr 2023 09:28:00 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Message-ID: <ZEqikAnNmjMxuSoU@google.com>
References: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
 <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
X-Headers-End: 1ps4TZ-003k44-De
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove some dead code
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
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/18, Dan Carpenter wrote:
> On Mon, Apr 17, 2023 at 10:51:46PM +0200, Christophe JAILLET wrote:
> >  
> > -	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
> > -	if (!ret)
> > -		ret = ret2;
> > +	ret = filemap_check_errors(NODE_MAPPING(sbi));
> >  
> >  	return ret;
> 
> Let's get rid of "ret" as well:
> 
> 	return filemap_check_errors(NODE_MAPPING(sbi));

Applied with this modification. Thanks.

> 
> regards,
> dan carpenter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
