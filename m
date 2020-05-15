Return-Path: <SRS0=D49P=65=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDCC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2020 01:04:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC392065F;
	Fri, 15 May 2020 01:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ood8UFDO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="meAn0iCv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k13lKwLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC392065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZOm5-00027Z-6W; Fri, 15 May 2020 01:04:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <martin.petersen@oracle.com>) id 1jZOm3-00027R-FT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 01:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:From:Subject:Cc:To:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lTuyXb1zzAAFeltFSGKcd91dSqPhr8vBIQ5tAf2GO84=; b=Ood8UFDOe0860hpqBXqm0cbUNE
 kPcHm1nc5X4LLb/tg7c7nsODUQgNg+8Uow/9SIi5Dj8egNTsKzTzR8DS5DouO0JV8LY7ErB3+EI36
 j0EYtoDK3Xmyv7db0aV/MdTldGbiQemSiMdwwdXsmovf3D12/Tr8yXnXRcEFcWOWumdQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:From:
 Subject:Cc:To:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lTuyXb1zzAAFeltFSGKcd91dSqPhr8vBIQ5tAf2GO84=; b=meAn0iCvCQf7IhBQ0l5MfAhpAC
 tRGiF5LhsWJR0mgEjGTJjYeh2htt+hDX8UihUc7ABCrcIybHgnEexoPVuxuiIVX9PRfgTAw6esZgf
 iXB9jcnxKgBkxmondS7s8TKbJ2xSJSGDzpvRqbmriJKEAxlrK+neW8OWvz85lASgbcPQ=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jZOm0-007n96-6E
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 01:04:27 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F11PTl104648;
 Fri, 15 May 2020 01:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=lTuyXb1zzAAFeltFSGKcd91dSqPhr8vBIQ5tAf2GO84=;
 b=k13lKwLP1ExxmJ0JwHGNgCI51Egbi6J5aoENT89TJbJnjhk4rhVPGruZVtelThL8GvtX
 AEMLMVUod0kS4YDTIn/WuoD58sRAoVRqL2vsgB9kbGVL+8j2ICIBXeBgaywmBGOEbWBl
 oF42PKxr1u+Ox1MdAT9+CI2IONDeXAl9vtMywAGiRuJLarm93Q0J+uPm40OWkLMIjAp4
 +ILwYrazH/4MRUKrRb/rrLaITa/LSea62BNNnPy9q6W2qko3yqctJ6q7ekXX+9YRqpqz
 oCnj5erPfQ2sYP5K/qVHD5qSKWNm0LO9+7rMpySAPQ6CoLjmcTeFY12VifV5eKT/3OPm Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 3100xwpmhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 May 2020 01:04:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F12iZb138042;
 Fri, 15 May 2020 01:04:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 310vjufqck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 May 2020 01:04:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04F14BZf004805;
 Fri, 15 May 2020 01:04:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 14 May 2020 18:04:11 -0700
To: Eric Biggers <ebiggers@kernel.org>
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
Date: Thu, 14 May 2020 21:04:08 -0400
In-Reply-To: <20200514051053.GA14829@sol.localdomain> (Eric Biggers's message
 of "Wed, 13 May 2020 22:10:53 -0700")
Message-ID: <yq1tv0irotz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=944 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=972 clxscore=1011 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150007
X-Headers-End: 1jZOm0-007n96-6E
Subject: Re: [f2fs-dev] [PATCH v13 00/12] Inline Encryption Support
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
 linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Eric,

> Then patches 6-12 can go upstream via the SCSI and fscrypt trees in
> the following release.

I'd like our UFS folks to review the UFS patches. But otherwise no
objection from me.

-- 
Martin K. Petersen	Oracle Linux Engineering


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
