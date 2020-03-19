Return-Path: <SRS0=57LO=5E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444ADC43332
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:50:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1057E2071C;
	Thu, 19 Mar 2020 11:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eXduuyFv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="h94WvMqS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q1IDVvl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1057E2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jEtgl-0005og-K8; Thu, 19 Mar 2020 11:50:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <william.kucharski@oracle.com>) id 1jEtgk-0005oZ-OS
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 11:50:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:References:Message-Id:Content-Transfer-Encoding:
 Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v7zEP7RtOUJktHuCXePFovWTz/T8i1lu/X2pjX1Hbbo=; b=eXduuyFvplv3ZylFNcHjr8W9c6
 gyX9SbVOc+eEoI8BNvr0lIoZsPlC1GGF8krZvhnyWA9SsxzOKM4B7d6cF1CYCbbFiaHMO8BM1Zemb
 NuAMv3qYuI0WD0CLNb96stZlcRPJx0MjjTsBT2NvXu1/pGvNRrfd2Wy455QAO5yFl5ZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:
 From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v7zEP7RtOUJktHuCXePFovWTz/T8i1lu/X2pjX1Hbbo=; b=h94WvMqSK6V1FkE/As8BPMOk8Y
 yzIoZ17BpIDaWrr0Jgx7PXNrdvbyxDYP6N9LY4NdRu9BWMThSV1Ffl8UZfm0dNobAHQOYDaafyLK+
 2hbl71VL2I+LAWRJpIkKl+rs6lXA0a0I1L8Yfv49sG7lBCT4xHF44J+UcShMPeZV/2fI=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jEtgi-000BzR-M6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 11:50:14 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgsVq127221;
 Thu, 19 Mar 2020 11:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=v7zEP7RtOUJktHuCXePFovWTz/T8i1lu/X2pjX1Hbbo=;
 b=q1IDVvl5ksTsjXMbCDWj+a3knqn+SAHj/kDVhAi11PV27RLxJ7D84msk3su8F04N1ajL
 VtqrcyTWBH0XhNSdSJ+JoSXHTgADauE0jfg1mDGVKuEw3I+JKcprJZAQNJ67JazR1VfE
 s3nm4Mf2oLZniCcfJJdP7T/ANyYbU4s+dxO14S5bHxqvtm+OOPUw9aIFsxOexf+QnfE4
 nS1BcO0nXJUGlSbAjYbOp8Kg+MDPXQTVBjY8E/fEVMcttJpKG8oLSAmAMwFBF0da2i3V
 rtwh4u6bTlBb4uIs0HtIYHl1MWNpOrxuuhyAWktvecikT5IAiVm05EkMOiaYi9QZ7L5m CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yrpprfua2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 11:49:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JBgha2113568;
 Thu, 19 Mar 2020 11:49:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 2ys8rkw5nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Mar 2020 11:49:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02JBngEO129865;
 Thu, 19 Mar 2020 11:49:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ys8rkw5mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 11:49:42 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JBnfQm014664;
 Thu, 19 Mar 2020 11:49:41 GMT
Received: from [192.168.0.110] (/73.243.10.6)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 19 Mar 2020 04:49:41 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
Date: Thu, 19 Mar 2020 05:49:38 -0600
Message-Id: <09A89B86-9F2E-4829-9180-AA81320CE2FE@oracle.com>
References: <20200225214838.30017-1-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=768 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190054
X-Headers-End: 1jEtgi-000BzR-M6
Subject: Re: [f2fs-dev] [PATCH v8 00/25] Change readahead API
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
