Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73745C38A2D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Oct 2022 10:31:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oo0AR-00022P-34;
	Thu, 27 Oct 2022 10:31:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <quic_pkondeti@quicinc.com>) id 1oo0AP-00022G-4D
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 10:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:CC:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gj6424IstWIBa5OAtWCYyoPzHMT5fhzmDPT5zQ+kSXY=; b=Duc52arq/DRa8UJvttQSkSB8qv
 sMNhuahH1DIagAKQ9OCF1PPzpBQ7nH6N+xyl3/FjBk5RoTECPYC6gV+CoktFHTROJXK2dxKZzJBvg
 kWmaDMZQqxSIzqHgUjSYU6FkP61CHDg7nxe9nCZFDFwFvMGcQ9LEDCG2CCILz66ZucQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gj6424IstWIBa5OAtWCYyoPzHMT5fhzmDPT5zQ+kSXY=; b=lOKEC62V/XCLMxMj/4mF1qRZiM
 OqVzdJ28ZohgQmPLDu6N/5R9l81ce59d0V/NAPxn3fmKtttIkEVWpNxwYPswybiusEGIxd/tNHelW
 RmBRUPGHwK/67nEp6+dVFf5dfbyTdy43eQIulriujchRMLnm6DjSH0NnR+OY1uCDzo0o=;
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oo0AK-001m00-Tg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 10:31:16 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RAT8Zw017735;
 Thu, 27 Oct 2022 10:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Gj6424IstWIBa5OAtWCYyoPzHMT5fhzmDPT5zQ+kSXY=;
 b=SGOTgvgoQ7N+LnVvO1KyrWfTAm7ImV5WtdGGAbhgMYDNZ4IPMa7ezREzlxme6O93zMHd
 k6tho13FaxO3ljr68OvXyw+kHIPBVJKL2jd2uX/yMaMWd9nyFvYv4zVtHSmcfZo9H/AM
 DhmNcq6hV+qwrEnl7LoqVxqAA7uJPmThUM0SP1l/VcbqpTaHIEmuW2Hm9jNhN98Frbpr
 pPyJAQk8toEzxif7QSzFEbLv3Bj2RwER1jgFS9MJESRpqGvXKFfwo7Ex9WjM3RfxfXer
 tKVkYVgWQ0cjHjQKNWIesXbspaceZFoPBSJZd3myoNo0qm82xHHbxe5qOYojQyfQb5fF 4A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahvsnny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Oct 2022 10:31:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29RAV2NZ026305
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Oct 2022 10:31:02 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 03:30:59 -0700
Date: Thu, 27 Oct 2022 16:00:55 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
Message-ID: <20221027103055.GB18823@hu-pkondeti-hyd.qualcomm.com>
References: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
 <1666861961-12924-2-git-send-email-quic_mojha@quicinc.com>
 <20221027101702.GA18823@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221027101702.GA18823@hu-pkondeti-hyd.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: bgQqJMOi-67EqHUBpImvwTipRzC0CKN6
X-Proofpoint-GUID: bgQqJMOi-67EqHUBpImvwTipRzC0CKN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_05,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270057
X-Headers-End: 1oo0AK-001m00-Tg
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix the msg data type
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Mukesh Ojha <quic_mojha@quicinc.com>, jaegeuk@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Oct 27, 2022 at 03:47:02PM +0530, Pavan Kondeti wrote:
> On Thu, Oct 27, 2022 at 02:42:41PM +0530, Mukesh Ojha wrote:
> > Data type of msg in f2fs_write_checkpoint trace should
> > be const char * instead of char *.
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> >  include/trace/events/f2fs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index ff57e7f..7fbfce4 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -1404,7 +1404,7 @@ TRACE_EVENT(f2fs_readpages,
> >  
> >  TRACE_EVENT(f2fs_write_checkpoint,
> >  
> > -	TP_PROTO(struct super_block *sb, int reason, char *msg),
> > +	TP_PROTO(struct super_block *sb, int reason, const char *msg),
> >  
> >  	TP_ARGS(sb, reason, msg),
> >  
> LGTM. one minor comment.
> 
> Declare it const char pointer in the trace point structure also.
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 11f6b71..22960e6 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1429,7 +1429,7 @@ TRACE_EVENT(f2fs_write_checkpoint,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(int,	reason)
> -		__field(char *,	msg)
> +		__field(const char *,	msg)
>  	),
>  
>  	TP_fast_assign(
> 
Never mind, I saw your other patch which makes it a string. Actually, we don't
need a string here as all the invocations (currently) are from ro strings like
below 

trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");

Thanks,
Pavan


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
