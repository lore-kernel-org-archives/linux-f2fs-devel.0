Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D3C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Oct 2022 05:01:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olk9k-0001sC-BD;
	Fri, 21 Oct 2022 05:01:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <quic_pkondeti@quicinc.com>) id 1olk9h-0001s6-Rm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 05:01:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4zR0bo5/TVeqLfecs2ICyveGAJFJeQXIbSWmGTzTSVg=; b=VWku01hCR4Q7V7VL7IbiKkH+qw
 s2pDUT6xL1gJhqepm6kEUgmW8WOCAUptw9hlWABnSysD9TBrmUlgQNYosdUnerBP9yQOABJUyd2Fm
 xKFaPRymV4FZAydjPdRUGr0kmuRKscl3Bby3PoMQg4okju5+AM0tkbrhXPTmwyl0Bbyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4zR0bo5/TVeqLfecs2ICyveGAJFJeQXIbSWmGTzTSVg=; b=MyCi3XEWkx07KRzTu6nJvfFfZt
 7M+OPT192BOcEMZVMo/QJ1BZKamgLLfVwjfyaPnVNasYzjp+5a/l4LVuuZ21e8DUMI41Iafy9SBpJ
 rba5B4NTp0Lrrd0XBVpLA8SY2kU7sVX334fZZv45Pnak9sGKdstduBcgvwYoNNifYGMk=;
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olk9X-0001bG-2m for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 05:01:08 +0000
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L4we9K000890;
 Fri, 21 Oct 2022 05:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=4zR0bo5/TVeqLfecs2ICyveGAJFJeQXIbSWmGTzTSVg=;
 b=M/Sv53M3aL9f6R0vYkh4giQJTodFu7nsUfdA6kzgpMV6pWdyOqwWGohT0yGp41sJ+6Tr
 VEwOMkSYey4HvMd3PyMcraBeVVOiReLEHYiU5q85QmwjUqjcQ4d47Q7PeOg6O1/Frquy
 EOemlQ+O7Ekev/dXaD+wBEdNyHqSnHtM5hW/HKka7Nt0xUtm2ItGIaudcOvBKRef8M5c
 mLAeScgiNWyddXIB3ugXhzO2hiyDnqmnw4ylGC2xgEv4NUOrirtExlc845gsALEkz0x9
 +fXvFinWsHDBSw8HwcSw9nX6hwr1KYbWt6pPl9YeZc6w8wYuxeTgf93xPoMGZ7JLoPO2 UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb8ckj2sf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Oct 2022 05:00:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29L50qXC030997
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Oct 2022 05:00:52 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 22:00:50 -0700
Date: Fri, 21 Oct 2022 10:30:46 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Message-ID: <20221021050046.GA31858@hu-pkondeti-hyd.qualcomm.com>
References: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1666196277-27014-1-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: shzaNGHJGwuhp0zB50xCc0wIJ3yRTYjg
X-Proofpoint-ORIG-GUID: shzaNGHJGwuhp0zB50xCc0wIJ3yRTYjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210028
X-Headers-End: 1olk9X-0001bG-2m
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the assign logic of iocb
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
Cc: jaegeuk@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Mukesh,

On Wed, Oct 19, 2022 at 09:47:57PM +0530, Mukesh Ojha wrote:
> commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> introduces iocb field in 'f2fs_direct_IO_enter' trace event
> And it only assigns the pointer and later it accesses its field
> in trace print log.
> 
> Fix it by correcting data type and memcpy the content of iocb.
> 
> Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  include/trace/events/f2fs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index c6b3724..7727ec9 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -940,7 +940,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
> -		__field(struct kiocb *,	iocb)
> +		__field_struct(struct kiocb,	iocb)
>  		__field(unsigned long,	len)
>  		__field(int,	rw)
>  	),
> @@ -948,17 +948,17 @@ TRACE_EVENT(f2fs_direct_IO_enter,
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
> -		__entry->iocb	= iocb;
> +		 memcpy(&__entry->iocb, iocb, sizeof(*iocb));
>  		__entry->len	= len;
>  		__entry->rw	= rw;
>  	),
>  

Why copy the whole structure (48 bytes)? cache the three members you
need.

Thanks,
Pavan


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
