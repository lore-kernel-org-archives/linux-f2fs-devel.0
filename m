From: Nicholas Krause <xerofoify@gmail.com>
Subject: Re: [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Tue, 19 May 2015 20:47:12 -0400
Message-ID: <55CD0467-9C9F-4B30-83E2-A29AF28DE794@gmail.com>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
	<20150519142943.GE20421@thunk.org> <555B4A32.3000302@gmail.com>
	<20150520003859.GA55280@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1Yus9q-0003Si-JV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:46:50 +0000
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yus9p-0001vl-Px
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:46:50 +0000
Received: by iesa3 with SMTP id a3so27604980ies.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 19 May 2015 17:46:44 -0700 (PDT)
In-Reply-To: <20150520003859.GA55280@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net



On May 19, 2015 8:38:59 PM EDT, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>On Tue, May 19, 2015 at 10:35:30AM -0400, nick wrote:
>> 
>> 
>> On 2015-05-19 10:29 AM, Theodore Ts'o wrote:
>> > On Mon, May 18, 2015 at 10:36:41PM -0700, Jaegeuk Kim wrote:
>> >> Previoulsy, fi->i_crypt_info was not covered by any lock,
>resulting in
>> >> memory leak.
>> >>
>> >> This patch adds a rwsem to avoid leaking objects on i_crypt_info.
>> >>
>> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> > 
>> > I'm not sure we need an rwsem to fix this issue.  In terms of
>> > serializing the creation and deletion of the structure, it should
>be
>> > possible to use an cmpxchg() on the pointer itself.  (e.g., if we
>lose
>> > the race on the creation side, we just release our structure and
>use
>> > the one that the winner allocated).
>> > 
>> > If we do end up needing to serialize access to the tfm in the
>> > i_crypt_info object for datapath reads/writes, then we might need a
>> > mutex, but I think that should be it, no?
>> > 
>> > 	       	     	   	       - Ted
>> > 
>> I have to agree with Ted here, as mutual exclusion locking is ideal
>> for the scenario here of a reader vs writer exclusion. My only
>concern
>
>What I'm saying is writer vs writer actually.
>
>> is that can there be many readers to one writer here as if so
>reader/writer
>> spin locks may be better.
>
>I could write another patch using a rwlock by removing needless
>down_write for
>f2fs_free_encryption_info.
>
That sounds good to me, I wasn't sure if it was writer vs writer or reader vs writer. However rwlocks are the easiest way to avoid dealing with semaphones as you seem interested in avoiding writing one into the f2fs code with this patch. 
Nick 
>Thanks,
>
>> Nick  

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
