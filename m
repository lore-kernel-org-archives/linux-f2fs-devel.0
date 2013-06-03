From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: Re: [f2fs-dev] [RFC 5/5] f2fs: add tracepoints to debug inline data
	operations
Date: Tue, 4 Jun 2013 07:45:24 +0800
Message-ID: <20130603234524.GA5816@hli22-desktop>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
	<1370253854-15084-6-git-send-email-huajun.li@intel.com>
	<1370267400.26799.90.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <haicheng.li@linux.intel.com>) id 1UjeRe-0007mx-Bm
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 23:45:46 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjeRd-0003Hz-Bj for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 23:45:46 +0000
Content-Disposition: inline
In-Reply-To: <1370267400.26799.90.camel@gandalf.local.home>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Huajun Li <huajun.li@intel.com>, namjae.jeon@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

On Mon, Jun 03, 2013 at 09:50:00AM -0400, Steven Rostedt wrote:
> Can you convert the above to use DECLARE_EVENT_CLASS() and
> DEFINE_EVENT(), as the above three are basically the same. You'll save a
> few K in text by doing so.

sure, thank you for the review.
 
> 
> > +
> >  #endif /* _TRACE_F2FS_H */
> >  
> >   /* This part must be outside protection */
> 

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
