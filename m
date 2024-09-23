Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85FCF9C6F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Sep 2024 07:43:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ssdjX-00007p-Go;
	Mon, 23 Sep 2024 07:43:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1ssdjW-00007j-Iu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Sep 2024 07:43:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5XDSSm93+GIFYOcODbZuiRWoBIYZq9juPEKbhK6Ft7g=; b=ifHOVyUPy/W7U7OdLfnJpyoL1B
 r0lVq0vvcQUzDicJHjGBicUqipF1RvJlZmAup1ASCNcpwigAzut6sc3BT7ZCSOPBYiBCoW3ZeYTWo
 JMhmuPBJTOZ6jw/9qrpLpTNgK1Q7HsPrZKejQKwGNIJ6sb/PAXo+qu0wtfu4VcSpZWhk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5XDSSm93+GIFYOcODbZuiRWoBIYZq9juPEKbhK6Ft7g=; b=lQ+SLeaLJiQdsGfMvITxSIIv8W
 NLUN+sJ+0DJKocMt1C7TynihivjOwXOEYy4r4OZ1HW17StLKKPRO9sO2ngPP6/b9du3sjVkstIPmw
 4d1C8BaCWzaJs77b3NL4oFXXsn7gigCMqJXSnhVzk7BKbiw9ZM+EZ6cXxse7R1kgG4t0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ssdjV-0005E0-DX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Sep 2024 07:43:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 343305C4C72;
 Mon, 23 Sep 2024 07:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC72C4CEC4;
 Mon, 23 Sep 2024 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727077414;
 bh=5Agj6cLd65Qf0AqMyAUd7lcCbRBnXVc6YrHae7VLBZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OIHBAlmeU0TujBRyqOQFJSoWFQK4xaGqo+yIwvzcHpvNAxJJSkypk1ClL18nmBEdB
 SmOOS0yPXlo956+ZR7td4I8yEyv39pCC6rcJZOyQR7BKTLOBCfbXH2SUOV4D+5EA35
 j1DIXnJH8drRIZ0RaUa8ffqLuIRxacH2xuFlc+VHZ8PQjzISD8jSoZeaycEPdyBUgb
 cHYyxEBa1mJfJs+boALgnEXa/3hHXP4VbDs9lAaXbE0f+1AFXbSQxmO+eAXiveAJIK
 28UyldB+f8zMLEWEhxp/3tMBLpmuooUVeRreY3K6ZQi4aZ+15il4g0nRAo8/P8qqAC
 gQCTTe82leTjw==
Date: Mon, 23 Sep 2024 00:43:33 -0700
To: Wu Bo <bo.wu@vivo.com>
Message-ID: <20240923074333.GA8390@sol.localdomain>
References: <20240923063732.2730521-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240923063732.2730521-1-bo.wu@vivo.com>
X-Headers-End: 1ssdjV-0005E0-DX
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not set STATX_DIOALIGN if dio is
 not supported
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Wu Bo <wubo.oduw@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Sep 23, 2024 at 12:37:32AM -0600, Wu Bo via Linux-f2fs-devel wrote:
> Therefore, if the filesystem does not support DIO, it should not set
> the STATX_DIOALIGN flag.

No, that's incorrect.  STATX_DIOALIGN supports reporting that DIO is
unsupported, via the alignments being 0.  See the statx man page.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
