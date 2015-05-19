From: nick <xerofoify@gmail.com>
Subject: Re: [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Tue, 19 May 2015 10:35:30 -0400
Message-ID: <555B4A32.3000302@gmail.com>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
	<20150519142943.GE20421@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1YuicR-0007Yl-1K
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 14:35:43 +0000
Received: from mail-ie0-f172.google.com ([209.85.223.172])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YuicN-0000m6-3o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 14:35:43 +0000
Received: by iesa3 with SMTP id a3so15196067ies.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 19 May 2015 07:35:33 -0700 (PDT)
In-Reply-To: <20150519142943.GE20421@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On 2015-05-19 10:29 AM, Theodore Ts'o wrote:
> On Mon, May 18, 2015 at 10:36:41PM -0700, Jaegeuk Kim wrote:
>> Previoulsy, fi->i_crypt_info was not covered by any lock, resulting in
>> memory leak.
>>
>> This patch adds a rwsem to avoid leaking objects on i_crypt_info.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> I'm not sure we need an rwsem to fix this issue.  In terms of
> serializing the creation and deletion of the structure, it should be
> possible to use an cmpxchg() on the pointer itself.  (e.g., if we lose
> the race on the creation side, we just release our structure and use
> the one that the winner allocated).
> 
> If we do end up needing to serialize access to the tfm in the
> i_crypt_info object for datapath reads/writes, then we might need a
> mutex, but I think that should be it, no?
> 
> 	       	     	   	       - Ted
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
I have to agree with Ted here, as mutual exclusion locking is ideal
for the scenario here of a reader vs writer exclusion. My only concern
is that can there be many readers to one writer here as if so reader/writer
spin locks may be better.
Nick  

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
