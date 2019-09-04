Return-Path: <SRS0=NDeK=W7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EDDC3A5A7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:05:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28C022CF5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Q4EPCkYm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ylb101Sk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GD2IqqoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28C022CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i5SAn-0005Pv-7X; Wed, 04 Sep 2019 10:05:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1i5SAk-0005PG-A2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Sep 2019 10:05:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wZiA2MC7EN7k/993lQcH6emTtjuEHiadr/nw0E+LSJw=; b=Q4EPCkYmj5EXG+tcI9hMt1FhDB
 DhfD5bpbqDR5u3uf81s/gKmyuUHwo5S8bGJ89GMGpzkLrKEqxQldXdmfV8SleV+iretIVVgYMZAdc
 BP+dHnH8w/9M+3bhLReb0bmTooo3d3mYDfGrXTQtsN4+AY2y/6J8b1+CwAogkW5qXaww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wZiA2MC7EN7k/993lQcH6emTtjuEHiadr/nw0E+LSJw=; b=Y
 lb101SkzxV/cfPpa/NkNJtn0skEhBEwEsyMaecSdTC5ExWKdmwjJWlpwf/Okhxh304SZ8EFX6Ta9M
 +78WJNRZnbpqEezAS/w6H/OHfz2BAzoR7J43zaZLerJwpS6AD7vXpE+nHzeXQkDtY1cIXHzwlwFwg
 s6XWQkSzFxJk6kfY=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i5SAg-008qc4-EP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Sep 2019 10:05:54 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84A4gHn123479;
 Wed, 4 Sep 2019 10:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=wZiA2MC7EN7k/993lQcH6emTtjuEHiadr/nw0E+LSJw=;
 b=GD2IqqoFBCAMshmoEaGXf1aKgTMMy7fmimnKHahVKWkdho59HRL1+NVjn7/SVjIMaED7
 VluLgw3ZOW069pSAtq6mrrfX0JBKqkl/R6LHH4xIcBOxK7C/jB36ewxgDmlbhMStoxJc
 erCF8KMCQbzpvqV9ezZN9cZNCjhqZ40E+IKLEpZUip5CTvkD0oCkhlrMI0QkVW04CLV8
 OqO1qcvfLMV3TvfawuMRAwwwG0gDSCi5RGysYkPpXRGxKlYhdtRXGS6n87TB2cAmNHGP
 Ry3RQHV8l4dEkMom4HmiPXW1/kY9XkD7mN3sNYNCSuB8wEB0rNkdXu8ZoqDhp6fUTPBO 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2utb5yr0jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 10:05:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84A3VF5124839;
 Wed, 4 Sep 2019 10:03:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2us5phxdux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Sep 2019 10:03:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84A2jYF010026;
 Wed, 4 Sep 2019 10:02:46 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 04 Sep 2019 03:02:45 -0700
Date: Wed, 4 Sep 2019 13:02:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Message-ID: <20190904100239.GC7007@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040100
X-Headers-End: 1i5SAg-008qc4-EP
Subject: [f2fs-dev] [PATCH] f2fs: signedness bug in
 f2fs_fname_setup_ci_filename()
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
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The error handling doesn't work because "cf_name->len" is unsigned.

Fixes: fbce5d4ab3ab ("f2fs: optimize case-insensitive lookups")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/f2fs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9de688a4e115..c83b666f9d7e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -157,7 +157,7 @@ void f2fs_fname_setup_ci_filename(struct inode *dir,
 	cf_name->len = utf8_casefold(sbi->s_encoding,
 					iname, cf_name->name,
 					F2FS_NAME_LEN);
-	if (cf_name->len <= 0) {
+	if ((int)cf_name->len <= 0) {
 		kvfree(cf_name->name);
 		cf_name->name = NULL;
 	}
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
