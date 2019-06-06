Return-Path: <SRS0=oA2u=UF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F3FC04AB5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:30:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D432083E;
	Thu,  6 Jun 2019 15:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ds5BcHoz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KX1tHKQI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="woOcfrQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D432083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hYuLi-0000os-Ca; Thu, 06 Jun 2019 15:30:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hYuLh-0000oe-5t
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 15:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F9Pe8iiITRC+INv7Pb3oZ7h6kOB6KWbAP6291TG+Zps=; b=ds5BcHozR8G8lbe6BbbulamZD+
 Lex2JWAdrqbdE3ayluRUg2x2A5VdZ8V890f7zxD171XNmtKB8BNYwhqMwv3Q1A/YJvL6zOv3vyiCM
 UUoyVtstXo26h+7HvIP3DSVCj5Zt66B1j2TS2Bqb6i7PiwzM18DjplfqmadDvaz6E6nU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F9Pe8iiITRC+INv7Pb3oZ7h6kOB6KWbAP6291TG+Zps=; b=KX1tHKQIwc3GAw372O8zX3JnpV
 x7HvBLajQTM2poxVyoaxT47Bt3QiGGk0xVcxCaHH2/dF7aRb64oxd85G45ApteZHnyzEQ1Yvfk/ki
 oHKDkJX04Y4Tqd0cySiPguNp3AYJhSEba7Hy0Ewlffnrld9UIkbNLRnxbD4GgYj0JZcU=;
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hYuLe-005MGd-Ag
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 15:30:40 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56FSllQ173914;
 Thu, 6 Jun 2019 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F9Pe8iiITRC+INv7Pb3oZ7h6kOB6KWbAP6291TG+Zps=;
 b=woOcfrQufGMFhDFP1y2RTDa8qUN6eNckHuSAFHtdE26srtOt4qwqJPE//u5Pe/aQ7fXU
 bkobW/2YdeqgCFqkeX2bu74Ebm9h14iWXDCWVA9No3CqnPeaYRHM1RFpdUGfnLBo0Zkk
 Pnp7OgOVY4gpO9KBEyWkfSlGz7Ym8DNL5+WKIGG1hbVuA9N110w9x8hY8m/KKPM+6MZu
 QQMR+zsS64u8AQB+Xf6oogPTnDXzIS0p6F3+IBDC0pz47ReV33SX4HW83RiGjrjb9sJm
 9oK/sL9/Qj1elqbpYh8a6fzRHeWKph10G7AgtIEgthb7919AMfjJ9gpHOVe2ay9sZ6Wf AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 2suevdsfxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jun 2019 15:30:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56FT4ex139851;
 Thu, 6 Jun 2019 15:30:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2swngmjmnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Jun 2019 15:30:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56FUOAI023747;
 Thu, 6 Jun 2019 15:30:24 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 06 Jun 2019 08:30:24 -0700
Date: Thu, 6 Jun 2019 08:30:21 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Wang Shilong <wangshilong1991@gmail.com>
Message-ID: <20190606153021.GA1700170@magnolia>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060106
X-Headers-End: 1hYuLe-005MGd-Ag
Subject: Re: [f2fs-dev] [PATCH 1/2] ext4: only set project inherit bit for
 directory
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
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
 Wang Shilong <wshilong@ddn.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190606153021.vVO32y7Fw5DqD_50D-oKuvUC8UXIx_a6VW5CmbT6SnU@z>

On Thu, Jun 06, 2019 at 01:32:24PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

It's good to be maintaining consistent behavior with XFS.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(applies to both ext4 & f2fs patches)

--D

> ---
>  fs/ext4/ext4.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..ceb74093e138 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -421,7 +421,8 @@ struct flex_groups {
>  			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> -#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL))
> +#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
> +			   EXT4_PROJINHERIT_FL))
>  
>  /* Flags that are appropriate for non-directories/regular files. */
>  #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
> -- 
> 2.21.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
